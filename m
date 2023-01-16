Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A166C2D4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjAPOyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 09:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjAPOxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A72410A
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Dbj18V5/A887FJIk0ZYnchMZ1TmG13nJtmPD9y76YrA=;
        t=1673880129; x=1675089729; b=Ws8QJmxgRQPGC4q+VW6aJqdmGAHUY4P84w3O33pUzuR+h1x
        3JUtliv/IayMj3jyhFZW5Us+7EIvL24G2oaZFSCCCI3KjHGRf6EX7Z8OsKTfq9Pun2kkd8ThJJTtW
        qX7H0VRoBXBBtP09D4fILYRb9PLNpAXFWWrNr07ItSng14m+EDYqiVwmblYnI/bRWlhhvL1b+LmW2
        +FMJdtRDyXb+an0EP0rkFzNoIDS2zeUGq9WKQixhPO+ePGfQ8IfAHf5lwZOJEZWkZ03cOodlN3tCo
        XdXmFbIHuYkmDvzPPPw9OJ+Vo9D1i2+L3KwRcMPZFW6V95LUXyOuR54UIHAK7nYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pHQgZ-003g2H-0u;
        Mon, 16 Jan 2023 15:42:07 +0100
Message-ID: <1d2ac266daf0e68d60d5a7074f96b2962c733a41.camel@sipsolutions.net>
Subject: Re: BUG: KASAN: use-after-free in ieee80211_mgd_auth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Mon, 16 Jan 2023 15:42:06 +0100
In-Reply-To: <20230112173808.6205-1-alexander@wetzel-home.de>
References: <20230112173808.6205-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

> 	if (req->key && req->key_len) {

You get into this with this code, I believe?

> // OK, no pointers. Can write into that
> 		auth_data->key_len =3D req->key_len;
> 		auth_data->key_idx =3D req->key_idx;
> 		memcpy(auth_data->key, req->key, req->key_len);
> 	}
>=20
> // The following line is the one KASAN complains about.
> // But we line itself looks ok for me...
> // We are using "fresh" allocated mem nobody but us knows (yet) about.
> 	auth_data->algorithm =3D auth_alg;
>=20
> /////////////////////////////////////////////////////////////////////////=
//////
>=20
>=20
> Here the KASAN report:
> (gdb) list *ieee80211_mgd_auth+0x59f
> 0x19fbcf is in ieee80211_mgd_auth (net/mac80211/mlme.c:6741).
> 6736                    auth_data->key_len =3D req->key_len;
> 6737                    auth_data->key_idx =3D req->key_idx;
> 6738                    memcpy(auth_data->key, req->key, req->key_len);
> 6739            }
> 6740
> 6741            auth_data->algorithm =3D auth_alg;

I think this is misleading you.

> Jan 11 12:37:35 debian kernel: BUG: KASAN: use-after-free in ieee80211_mg=
d_auth+0x59f/0xc50 [mac80211]
> Jan 11 12:37:35 debian kernel: Read of size 13 at addr ffff8881608bd4a0 b=
y task wpa_supplicant/624

Clearly, that is reporting a 13-byte memcpy(), and a *read* at that too,
so it must be req->key that's being used after free?

And I think the answer is some issue in cfg80211:

> Jan 11 12:37:35 debian kernel: CPU: 6 PID: 624 Comm: wpa_supplicant Not t=
ainted 6.2.0-rc2-wt+ #10
> Jan 11 12:37:35 debian kernel: Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> Jan 11 12:37:35 debian kernel: Call Trace:
> Jan 11 12:37:35 debian kernel:  kasan_check_range+0x35/0x1b0
> Jan 11 12:37:35 debian kernel:  memcpy+0x20/0x60
> Jan 11 12:37:35 debian kernel:  ieee80211_mgd_auth+0x59f/0xc50 [mac80211]
> Jan 11 12:37:35 debian kernel:  cfg80211_mlme_auth+0x298/0x570 [cfg80211]
> Jan 11 12:37:35 debian kernel:  cfg80211_conn_do_work+0xbd1/0x1020 [cfg80=
211]
> Jan 11 12:37:35 debian kernel:  cfg80211_sme_connect+0x51f/0xa90 [cfg8021=
1]
> Jan 11 12:37:35 debian kernel:  cfg80211_connect+0x986/0xda0 [cfg80211]

We came from cfg80211_mlme_auth() from cfg80211_connect(), so cfg80211's
SME.

> Jan 11 12:37:35 debian kernel: Allocated by task 624:
> Jan 11 12:37:35 debian kernel:  kasan_save_stack+0x1e/0x40
> Jan 11 12:37:35 debian kernel:  kasan_set_track+0x21/0x30
> Jan 11 12:37:35 debian kernel:  __kasan_kmalloc+0x7a/0x90
> Jan 11 12:37:35 debian kernel:  __kmalloc_node_track_caller+0x60/0x140
> Jan 11 12:37:35 debian kernel:  kmemdup+0x1f/0x40
> Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_connect+0x2bb/0x560 [cf=
g80211]
> Jan 11 12:37:35 debian kernel:  cfg80211_mgd_wext_siwessid+0x4b4/0x660 [c=
fg80211]

Here it was allocated.

> Jan 11 12:37:35 debian kernel: Freed by task 40321:
>=20
> Jan 11 12:37:35 debian kernel:  cfg80211_upload_connect_keys+0x1e4/0x700 =
[cfg80211]
> Jan 11 12:37:35 debian kernel:  __cfg80211_connect_result+0xfd2/0x18d0 [c=
fg80211]
> Jan 11 12:37:35 debian kernel:  cfg80211_rx_assoc_resp+0x606/0x1160 [cfg8=
0211]
> Jan 11 12:37:35 debian kernel:  ieee80211_rx_mgmt_assoc_resp.cold+0x784/0=
xea6 [mac80211]
> Jan 11 12:37:35 debian kernel:  ieee80211_sta_rx_queued_mgmt+0x358/0xed0 =
[mac80211]
> Jan 11 12:37:35 debian kernel:  ieee80211_iface_work+0x19b/0x410 [mac8021=
1]
> Jan 11 12:37:35 debian kernel:  process_one_work+0x684/0x1040

but this gives us a hint where it was freed

I think you might just be hitting some strange sequence of things? Or
it's just some really ancient bug?

I started looking at this but I guess the sequence shouldn't really
happen? Perhaps the fix is to either clear wdev->conn.params[*].cipher,
.key and .keylen when connect_keys go away, but that seems odd - maybe
we just need to copy the key into wdev->conn.key and not have that as a
pointer?

johannes

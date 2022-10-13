Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6125FD59C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJMHkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJMHkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 03:40:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E41343AEE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7OEj8OCTcXqSC5HaVHEW9InCKvzAtpPLeuuIHu9gcXo=;
        t=1665646803; x=1666856403; b=ErtbqFu064yNGkL1nFIlzz0LAFYLDxBk98Mv8mWLon0YKmD
        tZAy0Y+sLZHzP5w3/j55klW5RXXDb2KtT0fX2Q6VmnW+wJCGKyPeCujxCiH79AV2QliliWmDuGTuA
        bAns7JpOIV/fwQ3OQpf6SN9Mt7PTumrXMoLBFjaRJRshPJQZGp2O81ah5v+R9F9ZJGncAJ83RLcrp
        SyFpjQ/XH6Q8WJNIykNDoZ83IURmG1HIUAyQclgOoiiKtgIeEujnwCgjXLeEBQTnnqkwceoq1P4zc
        ym55qfJAgoJXA5nDRFQdLuUPoXN+C2UzCPXCv4+EG5ZwC4pGGqmh3/9zAuqR8h8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oisov-005bGt-2P;
        Thu, 13 Oct 2022 09:39:57 +0200
Message-ID: <e677e3cd1b5c34146017a65f28fabdb673a91d23.camel@sipsolutions.net>
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment
 sparse warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ajay.Kathat@microchip.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, lkp@intel.com,
        hostap@lists.infradead.org, Jouni Malinen <j@w1.fi>,
        Sunil Dutt <usdutt@codeaurora.org>
Date:   Thu, 13 Oct 2022 09:39:56 +0200
In-Reply-To: <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
         <87v8rik8vp.fsf@kernel.org>
         <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
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

On Wed, 2022-07-27 at 17:32 +0000, Ajay.Kathat@microchip.com wrote:
>=20
> I think, there is an another way to handle this issue. 'key_mgmt_suite'=
=20
> element in 'cfg80211_external_auth_params' struct should be converted to=
=20
> '__be32' type(like below code snippet) because wpa_s expects the value=
=20
> in big-endian format . After this change, the type case can be avoided.=
=20
> Though I am not sure if these changes can have impact on other driver.
>=20

Ugh. I think maybe it would be better to fix wpa_supplicant?

Thing is, we use the NL80211_ATTR_AKM_SUITES attribute here for it, and
even wpa_supplicant mostly uses that in host endian:

        num_suites =3D wpa_key_mgmt_to_suites(params->key_mgmt_suites,
                                            suites, ARRAY_SIZE(suites));
...
                 nla_put(msg, NL80211_ATTR_AKM_SUITES, num_suites * sizeof(=
u32),
                         suites))

with

static int wpa_key_mgmt_to_suites(unsigned int key_mgmt_suites, u32 suites[=
],
                                  int max_suites)
{
        int num_suites =3D 0;

#define __AKM(a, b) \
        if (num_suites < max_suites && \
            (key_mgmt_suites & (WPA_KEY_MGMT_ ## a))) \
                suites[num_suites++] =3D (RSN_AUTH_KEY_MGMT_ ## b)
        __AKM(IEEE8021X, UNSPEC_802_1X);




and also

                case WPA_KEY_MGMT_FT_FILS_SHA384:
                        mgmt =3D RSN_AUTH_KEY_MGMT_FT_FILS_SHA384;
                        break;
                case WPA_KEY_MGMT_PSK:
                default:
                        mgmt =3D RSN_AUTH_KEY_MGMT_PSK_OVER_802_1X;
                        break;
                }
                wpa_printf(MSG_DEBUG, "  * akm=3D0x%x", mgmt);
                if (nla_put_u32(msg, NL80211_ATTR_AKM_SUITES, mgmt))
                        return -1;


Now those are all userspace->kernel direction, but also:


        wiphy_info_akm_suites(info, tb[NL80211_ATTR_AKM_SUITES]);

which eventually uses

static unsigned int get_akm_suites_info(struct nlattr *tb)
{
        int i, num;
        unsigned int key_mgmt =3D 0;
        u32 *akms;

        if (!tb)
                return 0;

        num =3D nla_len(tb) / sizeof(u32);
        akms =3D nla_data(tb);
        for (i =3D 0; i < num; i++) {
                switch (akms[i]) {
                case RSN_AUTH_KEY_MGMT_UNSPEC_802_1X:


so again it's in native endianness.


So IMHO

commit 5ff39c1380d9dea794c5102c0b6d11d1b1e23ad0
Author: Sunil Dutt <usdutt@codeaurora.org>
Date:   Thu Feb 1 17:01:28 2018 +0530

    SAE: Support external authentication offload for driver-SME cases


is the problem there in that it assumed big endian for a value that's
clearly not meant to be big endian. And what garbage out-of-tree drivers
do we don't know ...

Even in the kernel, we have


static int
qtnf_event_handle_external_auth(struct qtnf_vif *vif,
                                const struct qlink_event_external_auth *ev,
                                u16 len)
{
        struct cfg80211_external_auth_params auth =3D {0};
[...]
        auth.key_mgmt_suite =3D le32_to_cpu(ev->akm_suite);
[...]
        ret =3D cfg80211_external_auth_request(vif->netdev, &auth, GFP_KERN=
EL);


but maybe that was never tested?

johannes

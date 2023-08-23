Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07EE7850AB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjHWGez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 02:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjHWGez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 02:34:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B2E59
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=a3Kw1m3sTWZpr7vRhEXtah4OAfpsV2xAyGg0LqKsvDA=;
        t=1692772491; x=1693982091; b=R/gjeri+0nP/AD9WLMAI1F3dqtunWj5tcW4EiLb6Tqk6l3C
        ALyYJMSUlffCI/q0XqveaOwqWoFMhl8AEVyrjEeClEMnpGrB8RdXAMJxoKs+uVPt/UOdhP3l5Vwi/
        1lGVWXU5dM+39ZIOROBWUP46dQlZ5xp+ygHaTl9soulWK+N5aNeiwqmJ9jNH5a5QqlNe7hpyfnTI6
        hovsYW93vYPYfWiDjkgKSAW8TfCDvEHOKRHbA7e+8ACS7pyWqkGkzlhxIhO98Vmer04SsJWt8Xjz7
        d0ag+P7j2pRLCxpmkL8AF0fgmZpQkpO4A7rW+ME2UFWVTOLV0TBteRqng/mqfG2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYhS1-006kBP-2v;
        Wed, 23 Aug 2023 08:34:46 +0200
Message-ID: <941b1bdb6852f20722fa3a5b01f546f054f9e8a8.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when
 assoc response fail for MLO connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 23 Aug 2023 08:34:44 +0200
In-Reply-To: <bcf65017-0dbc-e957-f382-98c6dc406346@quicinc.com>
References: <20230822100409.1242-1-quic_wgong@quicinc.com>
         <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
         <bcf65017-0dbc-e957-f382-98c6dc406346@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-23 at 10:28 +0800, Wen Gong wrote:
> >=20
> >                  /* need to have local link addresses for MLO connectio=
ns */
> >=20
> >                  WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
> >=20
> > makes no sense anymore. Not sure if that's the only one.
>=20
> After this patch, the cr.links[link_id].addr will be a valid local link=
=20
> address from
>=20
> struct cfg80211_rx_assoc_resp, so I think it is not needed remove now.

You don't understand.

The issue is that it's set the line above.

>                 cr.links[link_id].addr =3D data->links[link_id].addr;
>                 /* need to have local link addresses for MLO connections =
*/
>                 WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);

But look at that! What values can cr.links[link_id].addr get? Note how
it's a pointer - assigned from an array.


johannes

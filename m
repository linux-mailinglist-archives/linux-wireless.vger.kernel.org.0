Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8D783EA2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHVLQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjHVLQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 07:16:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7C6CCA
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mkW7mf7IDVG5Od3Z5Q/f49ZooKwzTbwmE/yQzEcHPI8=;
        t=1692702992; x=1693912592; b=khAL6s5V3QRGAdyN5HVxeC3NBmNc+G1vI/tA0SRukU25YUa
        HVBOYU7FE+WAcyiSp/Xx5qZiNZZRMfekeHrvsD+KjSMRIF3+c5MO1tcrT5Oq9Ep+Z5PpUKyb9OSoB
        QvMAlgUOgu4pOiByT2sDMD8DzAtb1V42U1SqnbpNhZr6RSvT53c7PEoyIGsU2nyX46/o0kdeJ2/1i
        QGwQ0E9iQvOx2A+DWy48RHMIwLMPGpTeUKjrBplmjdjbRDI8ERROfeBZECgMTX3rMF4DAQDMWtFEO
        sKA3AUDtwvQbB7131P02zPaWv/hn3l131NGNrn1IAIFrSglBmu2omA3h4eb5Zm0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYPN4-00536j-23;
        Tue, 22 Aug 2023 13:16:26 +0200
Message-ID: <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when
 assoc response fail for MLO connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 22 Aug 2023 13:16:25 +0200
In-Reply-To: <20230822100409.1242-1-quic_wgong@quicinc.com>
References: <20230822100409.1242-1-quic_wgong@quicinc.com>
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

On Tue, 2023-08-22 at 06:04 -0400, Wen Gong wrote:
>=20
> It is 100% ratio to reproduce the issue with this change.
> Add "mgmt->u.assoc_resp.status_code =3D 1" in ieee80211_rx_mgmt_assoc_res=
p().

Don't think that adds any value, but I guess I can always remove it.

> +		/* use the addr of assoc_data link which is set in ieee80211_mgd_assoc=
() */

not sure that's so useful? but anyway

The reason I'm even writing this message is that you didn't think this
change through:

> -		const u8 *addr;
> +		u8 addr[ETH_ALEN] __aligned(2);

That has some other consequences you need to adapt to, in particular

                /* need to have local link addresses for MLO connections */

                WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);

makes no sense anymore. Not sure if that's the only one.


johannes

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3978D5F5209
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJEJsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJEJsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 05:48:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58326CF41
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Dwb2XYnDYPU/uVg7t3IEcpdwDIXV3NYcpRiXDnqdrmk=;
        t=1664963325; x=1666172925; b=TLVSIVcHCH4nhHhqpGtgz7oT/TTMYkiP6QISAcHVJV2lx+V
        7RmUJKTkTfGJteEyf45pLSiKVhpNbQuOFSVlBp/F7K4OPBhaVlpm/+8h3v/R7daIyBbrrSlTOG+zO
        Au/5w+U3DR58P4fBY2ojVLCTOxndIKm1gR7GhxAUJY+NdfiJlx1Ukoxf8qo8803VoVIo7DpJlCQnD
        Mrdh2Bh9fXUiJhbijp2im470CBu17TYhSAHu9+3gKjaRLaKt5LxTXBCj903Tp/94cnjXEI7OfG40G
        hwHgbVTZr08zXFVK191jnjtNVf2zrVLzZcmdPG52a/KbHVaBz00AHIeOQNKVJwgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og119-00FyJw-0R;
        Wed, 05 Oct 2022 11:48:43 +0200
Message-ID: <1f98f992c4766acbecaeb7066e00b0ca2e2c64fa.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: info: print PMSR capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jaewan Kim <jaewan@google.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 05 Oct 2022 11:48:42 +0200
In-Reply-To: <20220923015550.1292547-1-jaewan@google.com>
References: <20220923015550.1292547-1-jaewan@google.com>
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

On Fri, 2022-09-23 at 10:55 +0900, Jaewan Kim wrote:
>=20
> +++ b/info.c
> @@ -741,6 +741,9 @@ broken_combination:
>  			pat->max_pattern_len, pat->max_pkt_offset, rule->max_delay);
>  	}
> =20
> +	if (tb_msg[NL80211_ATTR_PEER_MEASUREMENTS])
> +		print_pmsr_capabilities(tb_msg[NL80211_ATTR_PEER_MEASUREMENTS]);
> +
>  	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
>  		printf("\tMaximum associated stations in AP mode: %u\n",
>  		       nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
> diff --git a/iw.h b/iw.h
> index e712c59..0707cb4 100644
> --- a/iw.h
> +++ b/iw.h
> @@ -221,6 +221,7 @@ void print_vht_info(__u32 capa, const __u8 *mcs);
>  void print_he_capability(const uint8_t *ie, int len);
>  void print_he_info(struct nlattr *nl_iftype);
>  void print_eht_info(struct nlattr *nl_iftype, int band);
> +void print_pmsr_capabilities(const struct nlattr *pmsr_capa);

Also, FWIW, it would probably make sense to make this static and put it
into info.c at least while it's not used elsewhere?

johannes

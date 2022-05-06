Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC751D2C1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379325AbiEFIGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiEFIGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 04:06:32 -0400
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E767D18
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 01:02:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 1199210FB6;
        Fri,  6 May 2022 08:02:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t5BYBfOQa4ou; Fri,  6 May 2022 08:02:46 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 06 May 2022 11:02:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1651824166; bh=RCJkOaUcthZIMn+r3izHf30zgP9yvoYNq9DAQVJv5vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb+YtqgjOwn1Y/lP8u9XGdFqjToHDty1SJPt0yR/Y6FT9CksAK1lcIkY4R0rfDgX3
         sBoa09QaRDJvdYTVX4c5VO5HgjzHBISv5sxS/Ejmd2eLTdMcyDDUU5lOy9J/61W5ea
         00bKmBE/qOxVZBSNuyK35DUJq2omSKDsUYKs0qSQFXXCTlZda9M6xegqEhmthokuWz
         VNc0CcklTVo1Z4ZUrfBQh/WsJGLBx7qrj0M6BEMdM76cF3WOPWOfNVGDYqFb/lw0N4
         VeodM3rdmtnaFyvwTkdhJk7l3gxhqlLcJaJzoSHOkD/dkp/ohTuLaMu5GvjcgNWM3g
         Yj5uKoJs/tNYA==
Date:   Fri, 6 May 2022 11:02:44 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: consider Order bit to fill CCMP AAD
Message-ID: <20220506080244.GA866343@w1.fi>
References: <20220324004816.6202-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324004816.6202-1-pkshih@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Mar 24, 2022 at 08:48:16AM +0800, Ping-Ke Shih wrote:
> Follow IEEE 802.11-21 that HTC subfield masked to 0 for all data frames
> containing a QoS Control field. It also defines the AAD length depends on
> QC and A4 fields, so change logic to determine length accordingly.

> diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
> @@ -317,13 +317,12 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
>  	/*
>  	 * Mask FC: zero subtype b4 b5 b6 (if not mgmt)
> -	 * Retry, PwrMgt, MoreData; set Protected
> +	 * Retry, PwrMgt, MoreData, Order (if Qos Data); set Protected
>  	 */
...

For completeness, we should really do the same got GCMP AAD which is
identical to the CCMP AAD. In other words, these changes should be done
in gcmp_special_blocks() as well. Those functions should really have
next to identical implementation for the AAD part (nonce construction is
different, though). There were already some differences in the design
before.. Maybe all this AAD stuff should really be moved into a separate
helper function that both CCMP and GCMP could use.

-- 
Jouni Malinen                                            PGP id EFC895FA

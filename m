Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3127EE8A2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 22:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjKPVFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 16:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPVFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 16:05:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217983
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 13:05:09 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc938f9612so10426965ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700168709; x=1700773509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LnOWp0wbZeObmNmr90HTPFuULXlWCJKvWy7NEbdx0E=;
        b=Cx3rrpwiMA+lgEsz4EwweIWPJkgC/AV+JzsNbMWDAZwSv1XbGg3m0ozN1d3d41GJVw
         FblrASp4KQIRUn2wqYtDel50OluGwPLTaQCvP2USgZTEa38op2OueQ1UsBYE5kQUDH0q
         DeTfcOd09j4EJ1OgCJSg02i/jAcnBqWjCv1dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168709; x=1700773509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LnOWp0wbZeObmNmr90HTPFuULXlWCJKvWy7NEbdx0E=;
        b=IysXmSoj9z2fVelGMnLwSe+4Bunv5l72v9UcCdCXIbq2rzeBNP4GhQ+L/uWWK9/LN+
         b2NZabTwhJztbzgo47Xh0lzKgQq0uNiphYronnIFUyjUjYaU2C9FBOCORXgX63pb6I8u
         L6Sl2t8PSYbmUeiyXVdungLYGxF/frDw+bVxxUdTI+paS6DcE1ssktKZ23kOnA/2LyNg
         SzyevqYtKKXx47GvWW2FtjMvlYpb2gjvW/canJjtk6NQlrq3Srg0yKaeHE2vpg7/5W/X
         e72tmlgOxzltH/yt9UyG+2HEjDCwzmaT5QcoD7IUe4Z6D9couE4M1ff96K+jq9+kaRlh
         Jfxw==
X-Gm-Message-State: AOJu0Yyo9QG/FOex4u8UAf8WV8l1DehFvafF2oJ/WZtsVVg41APuCDbP
        X3fNs54d27DHLmxp1Z2cZFjclQ==
X-Google-Smtp-Source: AGHT+IHEcDMzDv8F2Oib5Qf07Br9pWMJl9y1OcHWOsIqcz/VA8rMATUHrvctjqpJr/W3EhXRV0fyVQ==
X-Received: by 2002:a17:902:8209:b0:1c9:d0a0:ee88 with SMTP id x9-20020a170902820900b001c9d0a0ee88mr3479430pln.62.1700168709074;
        Thu, 16 Nov 2023 13:05:09 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy4-20020a170903130400b001b86492d724sm93407plb.223.2023.11.16.13.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 13:05:08 -0800 (PST)
Date:   Thu, 16 Nov 2023 13:05:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix -Warray-bounds warnings
Message-ID: <202311161304.3B03C95B3@keescook>
References: <ZVaCNAohuieMmdq9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVaCNAohuieMmdq9@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 16, 2023 at 02:57:24PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
> flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The syntax looks a little funny initially, but yeah, that's how we need
to fix it for now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

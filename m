Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB170AF86
	for <lists+linux-wireless@lfdr.de>; Sun, 21 May 2023 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjEUScB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 May 2023 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEUR4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 May 2023 13:56:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125D1715
        for <linux-wireless@vger.kernel.org>; Sun, 21 May 2023 10:49:03 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so7519836276.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 May 2023 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684691343; x=1687283343;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HA5i5d/MKnlZtzhCD2oMZslei4xU+OAXwtdVXosID+k=;
        b=KsHJq9IMlQxSn1ymymDeONWRIBQ9QbDA+Vo5XChJkLsc/JeR0m+9onAFQopkmaRU8t
         UwAxopzCuCp6G4CBDWhbxNOtxib28QT2C/Gkj7ageBjZQAfFdH3TK2P/lDYiRqYmJlI2
         EoeX7ZbEXnTN9N+dDfnxvfctzgir/hIZEBBraYg+iVfleOMU59U9NHZeNT2+O5tRFSPG
         DGVk9Oo6JOJdnCPsmkb6rUw5IUyySqAth59rpsSDZKLdz9Yo2eyVPIhhEoQQuIk3md3o
         8Ul18TO9wcppcKna1BP5MU/OWqPd6WuAQVeuuOWHphmTPAb0TnJIppoI7KFmHLE2urOM
         HkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684691343; x=1687283343;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HA5i5d/MKnlZtzhCD2oMZslei4xU+OAXwtdVXosID+k=;
        b=AIEFIT2UGGQDSk1wRclhLHix6tEjkzIBgYQgvh8gYnHDo5DUr1by/FuafLZij4++vm
         qx8P98qIPsPdebL0xgkTuonT97zVx5vdtQepzl3Zj0VNzFjJoGv5bUNxUtc+B7T9+RUP
         CElNVYyL58LVxuOD/+0x8Tp83+q7q6vuTJKC+YCtEDgMLKcyUqOqMCLBE22F/2TfzX2K
         5E0mi42ChbG9ky9VU+wM+cUYbXX7TBNqn+KEln8JJak5YacCX9sbJWiuwDxvA/fG7MVy
         LCIAeXdMmK+oB0cEJeVCIZPpd5iMpHCdhusdp1duM41nX6E9Bz3S2KG+IUjP95qjIXgh
         cHKw==
X-Gm-Message-State: AC+VfDytOkSvL2w4kE9YyBCWYrVas6CVMdIz+fo5gxFsouHGHMr5G7tY
        DFKmx+Y46MgMMlmkCe+BBWKmzFpxnTE49bTB9euXB3gCHFk=
X-Google-Smtp-Source: ACHHUZ4vcfMyrkgGbEHgDaQ10EfDI+cPB7yCHp/bqpiX/PQH3ZIp0cLjwBYevD29UC76dHgsg09G0ag/APneTi4aBT0=
X-Received: by 2002:a25:71d4:0:b0:ba8:3a86:15ca with SMTP id
 m203-20020a2571d4000000b00ba83a8615camr8005285ybc.60.1684691343083; Sun, 21
 May 2023 10:49:03 -0700 (PDT)
MIME-Version: 1.0
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
Date:   Sun, 21 May 2023 13:51:33 -0400
Message-ID: <CAC6wqPVvke=Gy59yvYcaps2dwVzO=wfwdSTGNxFzAOWc5OpoDw@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: ath11k: Add rx histogram stats
To:     quic_mkenna@quicinc.com
Cc:     "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" 
        <ath11k@lists.infradead.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, quic_akalaise@quicinc.com,
        quic_mpubbise@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Was this really tested on QCN9074 as the commit text suggests...?

> const struct ath11k_hw_ops ipq6018_ops = {
> @@ -1132,6 +1147,7 @@ const struct ath11k_hw_ops wcn6750_ops = {
>  .rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
>  .reo_setup = ath11k_hw_wcn6855_reo_setup,
>  .mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
> + .mpdu_info_get_mpdu_len = ath11k_hw_qcn9074_mpdu_info_get_mpdu_len,

...

> +static u32 ath11k_hal_rx_mpduinfo_get_mpdu_len(struct ath11k_base *ab,
> +       struct hal_rx_mpdu_info *mpdu_info)
> +{
> + return ab->hw_params.hw_ops->mpdu_info_get_mpdu_len(mpdu_info);
> +}

I think you want to put this under qcn9074_ops. As of now, when
QCN9074 is present, it attempts to jump to a NULL pointer as
mpdu_info_get_mpdu_len remains uninitialized for qcn9074_ops.

And, do you not need to define mpdu_info_get_mpdu_len for all the
other hw_ops? If so, please be careful about defining it for
WCN6855/WCN6750 as there was a recent regression due to how the RX
MPDU info is provided by those firmwares as it differed from
IPQ8074/QCN9074. I personally do not have the appropriate literature
to determine whether or not this is consequential or not here as well,
though it seems like it would be:
https://lore.kernel.org/linux-wireless/20230404072234.18503-3-quic_youghand@quicinc.com/

Tyler

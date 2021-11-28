Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC31460816
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbhK1RgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 12:36:25 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:35550 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbhK1ReX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 12:34:23 -0500
Received: by mail-qk1-f181.google.com with SMTP id m192so20326344qke.2;
        Sun, 28 Nov 2021 09:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HOZnfEPnttr55dyGpAF+JeLswq5rht0r3DHq2CKTKuk=;
        b=vCpf3eMWJiUxkhHkhreZjNxgtv5z/gN8zCRPUN92bioplJ/trEv/BZvXmIVE0Vd1uc
         VxUh6I2VyJgWD8PpeJqJIwjA7SuarG86KNq8oAC6DOXt/Q13D2ssXM2Wa4hdbZ80gCq1
         wmM15R80RHfYx7oFN8HVYSrVwtyqKGxoto0BVAKc9gvxPadpMYb0JmVYLt5AwJzdpdgx
         vPqvhac+PfAZQmybL3b42ICZQFGDbTSPVbVOft7mWSXS/DajsfzuVeeuUjpc99JHPNdg
         nJVFjH4LeiknoZfnufaZTWFBqcFEQtOTcOQZwqC/s05qdJD26Nd4clS0UOLf+BK6hypg
         U0pQ==
X-Gm-Message-State: AOAM531xMq7tuZBU45nqWCEeBWjkNcyKHkdGRcdHtNIv8yFM15GQ7RQ6
        MQrXB3Xzy4kQ7388YkUN64HMr2CFxw==
X-Google-Smtp-Source: ABdhPJw2+ifIMe/CTu4PVjr7v5xnwHL3/1YCQErz+a7uZySRa0cZy8m8hz+QmW2K3pxxRGtHLFXxnw==
X-Received: by 2002:a05:620a:1a19:: with SMTP id bk25mr33386927qkb.479.1638120666584;
        Sun, 28 Nov 2021 09:31:06 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:2edc:4e01:e871:814a:5254:ea69])
        by smtp.gmail.com with ESMTPSA id a17sm5824475qkp.108.2021.11.28.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:31:05 -0800 (PST)
Received: (nullmailer pid 2774543 invoked by uid 1000);
        Sun, 28 Nov 2021 17:31:03 -0000
Date:   Sun, 28 Nov 2021 11:31:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dt: bindings: add new DT entry for ath11k PCI
 device support
Message-ID: <YaO81+V2Mt/ImYxO@robh.at.kernel.org>
References: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637839211-1503-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 25 Nov 2021 16:50:10 +0530, Anilkumar Kolli wrote:
> Ath11k driver supports PCI devices such as QCN9074/QCA6390.
> Ath11k firmware uses host DDR memory, DT entry is used to
> reserve host DDR memory regions, send these memory base
> addresses using DT entries.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> ---
> V4:
>   - Fix dt_binding_check warnings (Rob)
> V2:
>   - Use reserved-memory (Rob)
> 
>  .../bindings/net/wireless/qcom,ath11k.yaml         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

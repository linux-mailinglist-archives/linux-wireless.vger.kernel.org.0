Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE961BC42F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgD1PzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 11:55:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41169 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgD1PzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 11:55:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so33421426otp.8;
        Tue, 28 Apr 2020 08:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/TydElCkArBzhog9A76R0UknEmptmdX1tix+Usu5wU=;
        b=ossXePJfJSoLIXHPj7kmNgLaKPlvHPAyo2DqOWvyhqZk51nbs6cZKJRdzPMAUz/2Zb
         cMPJljz5qf4pidBcSDtHMdCmWB7/ZKje2QH2GTJbYInNP8FdqDKY+hJ39rN+8XRxEUWA
         HDiUmytmci55rkTKCITdlmc0qDcSg5Fr2Pz6lo3rJfRuqAIdKpjweptEfe3CMzIn6AIa
         L0SxlN2tnjKonKWMFSmPzrf8MYyTrwM7oVj7QMLTQ1tEekRdAnPd7Ox+T7PNtssG1lqA
         Y3HagiIeUeamKwxZYXAVwaFCUVGUtXvMb9RIWANOk0cejHReNSiBiIyB9QhaW+Y8GaNR
         1mHw==
X-Gm-Message-State: AGi0PuZO0Ei8hO6ubdmMMYrTB0Pr0bcj2bX+h1QvYyAfdmtOxkZllZAw
        yr17CdF64UPnJD3R6EccZq5tHKI=
X-Google-Smtp-Source: APiQypLk5ukhxmRNHN9chkS+4R+a6N/pjUn+lFfl6zwAhvJu+8TRSrJ7WgfuuegVBXhgFeZ9TxMPWQ==
X-Received: by 2002:a9d:37a2:: with SMTP id x31mr24139971otb.52.1588089315214;
        Tue, 28 Apr 2020 08:55:15 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x82sm4935915oig.55.2020.04.28.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:55:14 -0700 (PDT)
Received: (nullmailer pid 29682 invoked by uid 1000);
        Tue, 28 Apr 2020 15:55:13 -0000
Date:   Tue, 28 Apr 2020 10:55:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: ath10k: Add wifi-firmware subnode
 for wifi node
Message-ID: <20200428155513.GA29618@bogus>
References: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
 <1586971906-20985-2-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586971906-20985-2-git-send-email-pillair@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 15 Apr 2020 23:01:44 +0530, Rakesh Pillai wrote:
> Add a wifi-firmware subnode for the wifi node.
> This wifi-firmware subnode is needed for the
> targets which do not support TrustZone.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

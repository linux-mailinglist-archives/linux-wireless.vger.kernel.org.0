Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4C293061
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbgJSVSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 17:18:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42493 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732742AbgJSVSx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 17:18:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so1603254oix.9;
        Mon, 19 Oct 2020 14:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5iclHCksvBuMilzA7GHXwWKzvA2Te2MmABUBA/NB4Q=;
        b=W5H85bzq+/zRXbtssys1/R9laPP/+8Qfs8v/zVTnz8r/vzdj0MW6fk7weRUU9K6DLO
         aLt26IQEHQHZTroRGMBBTNSTtFAm5ZsDnYZchL36UlvB3rQW3Kw2B9aHyl1MK8PfQsqE
         mcPVKBRVW+PXEUyO+y6HXox38TBWJ+JGzOSR+TJU6S/x4uIIQwWW9Wlwoe9S2+Zeb6nn
         XTs4bAN2POVdIxt2h4Y/FzYgSEvZNTyIap7adUEFn4yei4DX7W4oPwcGwC+5M0PH1O3E
         lLOOZtACEJWdAUQ/A9jT1F0A5oXWJv8qebqniD0tzp+rHhJNn0Ow2AGfzDueoRDQxgUg
         /nwQ==
X-Gm-Message-State: AOAM532AF9+PbiQ+njmBzJ3ukQLKyo0hP5NxM9wC4O0j+FDgaOrPvFm4
        KBmqIyLcgPmuih9o1pfk6Ekon+VCMA==
X-Google-Smtp-Source: ABdhPJxwu9Ek3hrbRfIG15yX+NBBixEIisvc2pKDQ/6o1ahbkV6cysEMXB3E3Dq8jDO3h55s8yg/Kg==
X-Received: by 2002:aca:ab8b:: with SMTP id u133mr914071oie.132.1603142332991;
        Mon, 19 Oct 2020 14:18:52 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm237236otk.19.2020.10.19.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:18:52 -0700 (PDT)
Received: (nullmailer pid 3619342 invoked by uid 1000);
        Mon, 19 Oct 2020 21:18:50 -0000
Date:   Mon, 19 Oct 2020 16:18:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: add new dt entry for ath11k
 calibration variant
Message-ID: <20201019211850.GA3619287@bogus>
References: <20201015131501.1939685-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015131501.1939685-1-sven@narfation.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 15 Oct 2020 15:15:00 +0200, Sven Eckelmann wrote:
> The bus + qmi-chip-id + qmi-board-id is not enough to identify the correct
> board data file on IPQ6018 based devices. Multiple different boards share
> the same values. Only the original reference designs can currently be
> identified and loaded from the board-2.bin. But these will not result in
> the correct calibration data when combined with the pre-calibration data
> from the device.
> 
> An additional "variant" information has to be provided to select the
> correct board data for a design which was modified by an ODM. This follows
> the same approach as ath10k.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C213A4AFE
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 00:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFKWr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 18:47:29 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44814 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFKWr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 18:47:28 -0400
Received: by mail-pf1-f171.google.com with SMTP id u18so5583683pfk.11
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jun 2021 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZzescfOSlgqNZTqR9N0kVxOEOtw3u9zSvRE/ph0KSok=;
        b=F+akhNRctHyK0g6UndS6X0AnZML559bWF5FvHWgjt67AOpaNqV++Xt/f3uBgQp2iQt
         i9pZ+fBBpV5cmrwTTSQwMwnx9reAinWuP/B++s0Hk52iyVDtpcfUmaI2+d6FyTW3hni4
         7LswOnpeIUzdyk4cRzEHIcEOwrk0manZuT3Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZzescfOSlgqNZTqR9N0kVxOEOtw3u9zSvRE/ph0KSok=;
        b=TKdBk0RMYwsnAG8OIqkMTSBdR/ITqVuLtyO5xZyITRuOZqjnTSNILSCtYergIHDIby
         kOGPB8EQ1ZoiUVYu1zgALbI/UU8LXTQCX4lDN0jwHIpvpXbXbz82ZUXoIjdcaeNKrfIR
         v3W7S05CKA7f7NidDjPHLE2kjVn/G9A2cIaI3x1LsGN1nCLnttouK9ro1HMDLBgefjM2
         Gkt0JpnDuiWa1jXOr6efzqNHQHxFboZ+Nhs1n4rc26mWdMDBl6tWIKjhSsRBkRLm5UKv
         1cqheS4wLuKFsZkdK5qLtTTRgQj6OfciRdmYDaCr823sbUkmUy2bN8mDh5AkmE/sQ04R
         ftEw==
X-Gm-Message-State: AOAM533yzHBwKEvEbSodGJN8QVKji0c9SOnjCEeRBMuHvYf2pPk6H5yB
        wW7LSum3Mz49DOSbEOblFgZ0/A==
X-Google-Smtp-Source: ABdhPJwnTuRP67/EtMuCVcGA3tcL/unEiaeJ/aAU+Erru8h8mqzWl+J+aG0okva8noah9Tvo1pLGKw==
X-Received: by 2002:a63:4a49:: with SMTP id j9mr5765159pgl.234.1623451458728;
        Fri, 11 Jun 2021 15:44:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a053:7c1f:32fb:81d0])
        by smtp.gmail.com with ESMTPSA id 21sm6237634pfy.92.2021.06.11.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 15:44:18 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:44:15 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, steventing@realtek.com
Subject: Re: [PATCH v2 1/2] rtw88: follow the AP basic rates for tx mgmt frame
Message-ID: <YMPnPwWf8PGlkt3A@google.com>
References: <20210422030413.9738-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422030413.9738-1-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Apr 22, 2021 at 11:04:12AM +0800, Ping-Ke Shih wrote:
> From: Yu-Yen Ting <steventing@realtek.com>
> 
> By default the driver uses the 1M and 6M rate for managemnt frames
> in 2G and 5G bands respectively. But when the basic rates is
> configured from the mac80211, we need to send the management frames
> according to the basic rates.
> 
> This commit makes the driver use the lowest basic rates to send
> the management frames.
> 
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: move debugfs as a separated patch
> v1: the original patch is "[PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame"

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF96DDA9E9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393194AbfJQKZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 06:25:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35201 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392929AbfJQKZ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 06:25:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so1362227qkf.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0ip6WAgVJtpPTmlBVbm7y2ouMDnUH6SSNtB5DydH/g=;
        b=ubZ2Wwz+kM7yzuaXvVMf67BboDVb9g36K24t2GNsmoDCUcFFqc5R0kIUsBCSriT8+s
         g2THEceQYmIWWmHWK5IyTXMIrJ2udOf48bA4BhuGk/XetN5gIXS0HXHxKgI3B7PKVInZ
         EFFITZf+R5UP0H5BIWxbZMci6vOKPBfGbGLr9QPC4sY3lEsukWQvWZWWI9r2BYI2GMu7
         JGcxzCocioDYbWYTj58nbzs5vm/ToBtm2pjzywpksAhfKleYayeprvLkbcnhIKeKk80h
         PYOE+1ed/0ZJwHWwrWpGci2BQCoITb9h56COSuUpoznJ+CpINaGnqpf0gQGK2SrW2ytj
         Ga0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0ip6WAgVJtpPTmlBVbm7y2ouMDnUH6SSNtB5DydH/g=;
        b=SterWo3QNY7B3Jfh0LRL2jJBIjjI29zq8gfhLkOWQvBnp3otj+EaUc0+YQyIPk0egN
         9FmU+qj34SJPQe0FcZ4G6TeguIjw179CdelYsH+FIZe6TPc9Dxkn8bvYM+90bW307AiS
         3X7jNURKW+/nt1Q43c7cIMHJEnmNBAWLY20FsGVslg9A/Xu9i2gpqZyJ/Vkd+AQxHHlD
         Fjvh7PpfziNPMNFjSZx2nvk+F8tYRP3E+UvpQsiIdq1ekyEs7toX7m7fYnqDuNRanUSR
         oLKV1c5PxdGCLETnc9G+8yYHUJ2hBhN4R34lFBzF353ATFht1vRTh+fSeG/I9q8GFwR3
         RxPQ==
X-Gm-Message-State: APjAAAX5PbbB6YiL2WHnLPXQgRK1HkLwlCj/7Qnq4c9BK+izBytaLX+i
        DgUoJU2i0JKT2m20f5OQN6sK63SzynWp4WTpwaddtw==
X-Google-Smtp-Source: APXvYqwcKpy48N4mVayIyo3Z2d6n0huFpsIZT715ay02FEIBywAJWSlozCna4jTM/e50q8zP/UEmTczMQZdNNu7g6lk=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr2613314qkm.250.1571307957833;
 Thu, 17 Oct 2019 03:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-6-yhchuang@realtek.com>
In-Reply-To: <20191016123301.2649-6-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 17 Oct 2019 18:25:46 +0800
Message-ID: <CAB4CAwe-9Ne-cSJC45bpggBKCsJ_UDFuFdB3f-wf7+A=qVnKnw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] rtw88: add set_bitrate_mask support
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 8:33 PM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>

> +
> +       band = hal->current_band_type;
> +       if (band == RTW_BAND_2G) {
> +               band = NL80211_BAND_2GHZ;
> +               cfg_mask = mask->control[band].legacy;
> +       } else if (band == RTW_BAND_5G) {
> +               band = NL80211_BAND_5GHZ;
> +               cfg_mask = mask->control[band].legacy << 4;
> +       }
> +
> +       if (!is_vht_enable) {
> +               if (ra_mask & RA_MASK_HT_RATES_1SS)
> +                       cfg_mask |= mask->control[band].ht_mcs[0] << 12;
> +               if (ra_mask & RA_MASK_HT_RATES_2SS)
> +                       cfg_mask |= mask->control[band].ht_mcs[1] << 20;
> +       } else {
> +               if (ra_mask & RA_MASK_VHT_RATES_1SS)
> +                       cfg_mask |= mask->control[band].vht_mcs[0] << 12;
> +               if (ra_mask & RA_MASK_VHT_RATES_2SS)
> +                       cfg_mask |= mask->control[band].vht_mcs[1] << 22;
> +       }
> +
> +       ra_mask &= cfg_mask;
> +
> +       return ra_mask;
> +}
> +

I believe you can replace the 4, 12, 20, 22 with a more descriptive macro.

Chris

> --
> 2.17.1
>

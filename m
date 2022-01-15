Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303CA48F75B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiAOOyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jan 2022 09:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiAOOyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jan 2022 09:54:05 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321BEC061574
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jan 2022 06:54:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a5so5521961pfo.5
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jan 2022 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgQIufHzWPaegMvECWvqWJAVmHT2caDdTtGBI0wm+bY=;
        b=wJotTsKisl222ZFNbwWXt89OP0zZLhuTKCI6cn8XcySMa8d2Upxzs08DVcNCuD1WBq
         dAnI2CmtSa8guQHnAcDDOr8vmsutEXMkNw1ejSxlV1DCAseVODdEWGCd1tFkPKfyZOmz
         +4v1zKGGQVj976yP+FGVHkBQM9dpJAdXVVtpcfhb3SVM5Cy5XxnJAB0IZRhCYCopLomW
         BPkFyrbs69/TTU+l9KSyx/PsBbl/cUN3olmqBWONvLu5T97LPBIKsEfbh3kYAg2spCg8
         d+alnQWzY08Vkm54baM4ECIexGywBE0/qL85aWOfEdxxhTQ/ocSrsQCP+guYtSYDKTLn
         n+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgQIufHzWPaegMvECWvqWJAVmHT2caDdTtGBI0wm+bY=;
        b=NtcHvwh1y9Z/llcaaiYFqMJ0r0l5m2aLRVF0pOuMdgUC2Jga1D/akCOKP9MCCxbIxb
         14+G6sF3y63onKNf0XLcP1NmvF7XbMgX46FlmSUabLzvzBOX8whMl0BYMXpVUsboEPym
         6RpKC0vHKF/hUwpr/bNsD93nsqbuDopcbkho86YmH3OGIM5xk/0zEnnhVGNBhOli30sU
         6Ax7HaxyxHZMx9vI7PRNVnV/3DIWc3zhORAqYhkJX1hyv2/YGC1Vn8A8qQO6z/VLHZQQ
         KSwhClcU9dd+XyODTe5JA8Mkf3iBMZJVPVXyl9hOgJkt/3gNEGGlC6WW2wfoz1Mz4y+i
         TLaw==
X-Gm-Message-State: AOAM533/Ih8Ft+EUYUjB9Be7CJv6HZ1TQ/wF1OqOMf3MkUsOcKH6a3GQ
        r5rl1fpRQsleEsqnhhCfNX7XLpJPkgDyhwV1za9s+wqH6vY=
X-Google-Smtp-Source: ABdhPJyqDv9BBM7fSpdA3Ox2OtzLMzWErXZOfD2bRUH0cVRfJKQKWSIwCUbxYk03gxUoQCVArI98ojtu0OF2tDa1L5s=
X-Received: by 2002:aa7:8612:0:b0:4c1:3613:2e4b with SMTP id
 p18-20020aa78612000000b004c136132e4bmr13725663pfn.74.1642258444531; Sat, 15
 Jan 2022 06:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20220114010627.21104-1-ricardo.martinez@linux.intel.com>
In-Reply-To: <20220114010627.21104-1-ricardo.martinez@linux.intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sat, 15 Jan 2022 15:53:28 +0100
Message-ID: <CAMZdPi-4N=cRcoie=2zHRsCJra1oi3WBPiFbcjJZ-3Qm-yCKcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/13] net: wwan: t7xx: PCIe driver for
 MediaTek M.2 modem
To:     Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net,
        ryazanov.s.a@gmail.com, m.chetan.kumar@intel.com,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        amir.hanania@intel.com, andriy.shevchenko@linux.intel.com,
        dinesh.sharma@intel.com, eliot.lee@intel.com,
        ilpo.johannes.jarvinen@intel.com, moises.veleta@intel.com,
        pierre-louis.bossart@intel.com, muralidharan.sethuraman@intel.com,
        Soumya.Prakash.Mishra@intel.com, sreehari.kancharla@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 14 Jan 2022 at 02:06, Ricardo Martinez
<ricardo.martinez@linux.intel.com> wrote:
>
> t7xx is the PCIe host device driver for Intel 5G 5000 M.2 solution which
> is based on MediaTek's T700 modem to provide WWAN connectivity.
> The driver uses the WWAN framework infrastructure to create the following
> control ports and network interfaces:
> * /dev/wwan0mbim0 - Interface conforming to the MBIM protocol.
>   Applications like libmbim [1] or Modem Manager [2] from v1.16 onwards
>   with [3][4] can use it to enable data communication towards WWAN.
> * /dev/wwan0at0 - Interface that supports AT commands.
> * wwan0 - Primary network interface for IP traffic.
>
> The main blocks in t7xx driver are:
> * PCIe layer - Implements probe, removal, and power management callbacks.
> * Port-proxy - Provides a common interface to interact with different types
>   of ports such as WWAN ports.
> * Modem control & status monitor - Implements the entry point for modem
>   initialization, reset and exit, as well as exception handling.
> * CLDMA (Control Layer DMA) - Manages the HW used by the port layer to send
>   control messages to the modem using MediaTek's CCCI (Cross-Core
>   Communication Interface) protocol.
> * DPMAIF (Data Plane Modem AP Interface) - Controls the HW that provides
>   uplink and downlink queues for the data path. The data exchange takes
>   place using circular buffers to share data buffer addresses and metadata
>   to describe the packets.
> * MHCCIF (Modem Host Cross-Core Interface) - Provides interrupt channels
>   for bidirectional event notification such as handshake, exception, PM and
>   port enumeration.
>
> The compilation of the t7xx driver is enabled by the CONFIG_MTK_T7XX config
> option which depends on CONFIG_WWAN.
> This driver was originally developed by MediaTek. Intel adapted t7xx to
> the WWAN framework, optimized and refactored the driver source in close
> collaboration with MediaTek. This will enable getting the t7xx driver on
> Approved Vendor List for interested OEM's and ODM's productization plans
> with Intel 5G 5000 M.2 solution.

From a WWAN framework perspective:

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105974340CF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJSVyi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 17:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 17:54:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CAC06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 14:52:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so14710926plb.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=O9IDZ0D8GKm/bErqw2ZE+yWUnfK4r6dVEZoythVTIk4=;
        b=cEk/qXLCTxQgN0hZ98x6htdkpzB1m/U4unQTZAmVTEHsEJkzFq1BFK+qPSuioM5tWg
         Nfus3JfvnfAyp6/Y8zFl+cimoOwjz9jmQbVh5xMXMhqyRdjAuuApjHg0vcWpY1GZJJYT
         WbMWUFzqDYE1gI59VLr3VEMFYEOYULj0A31KnFWSXC9dzK9fRL8PmXBKPtUCIqg+YIy6
         H3BPeySkWuXfnguHAUdmjUkvADX7/woVTsRmUp36oxn60WZTHO3IUWzDmFbo3zkP9vIC
         RfSNCnqc1I8OxokrNol+XyO8h4/kEPOAyBX9KkdrHz327FLfTdhxLWZ6kvAAR6v0a9h9
         sR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=O9IDZ0D8GKm/bErqw2ZE+yWUnfK4r6dVEZoythVTIk4=;
        b=UrhuDNp4YudHXMWnsjMXplwtZi7wtRmw9sPQUV7hPPcWXTnsM9hzab+FAcI7hLKuuP
         ngD7pz24Aawf/kvWoEVHKeNO6MthVbaPuKMGJkPDdxBqOy4OUoc5NkvZLtZHOniXaJ/T
         EJpGspDpykjVvOrLcAbmDePoTuRt1Np+IPjQIN1porBoeqCgm5ivP5qbfJ0nMgU1hsEJ
         234On51H/+Nm3VHJoE/gzs3ii/1pJwzcl+ER6fHyy0Q+hVTqyT43H1h2OYVH/0VF57WL
         yc7kCAF3dtXPQK+CoLdpGPfZM+sxvAQmOErkaa9OzjsvFVfLcTt8bsrJDbhtBvTMPp2U
         syQQ==
X-Gm-Message-State: AOAM532MmmtKwDDCNdob/abgz/c/rl/eedjoBeqDCmgYl9gThRGtmft7
        AHu602P5J5Xqmg2kIIwhO/GfMfDa8pc=
X-Google-Smtp-Source: ABdhPJySlB0dYbIQji1DfQtj42es3K0gCgZqs7IB918tSzVo7r0A88PlFv5oH7QzPnse58aeRIsuew==
X-Received: by 2002:a17:90a:c70d:: with SMTP id o13mr2786132pjt.143.1634680340218;
        Tue, 19 Oct 2021 14:52:20 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.163.188])
        by smtp.gmail.com with ESMTPSA id t9sm3603784pjm.36.2021.10.19.14.52.19
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:52:19 -0700 (PDT)
Message-ID: <66d0e0e76b3da052eb25199c9665ca74fefa3dbd.camel@gmail.com>
Subject: Bug - brcmfmac STA fails to channel switch
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 19 Oct 2021 14:48:58 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I've noticed some funny behavior on brcmfmac STA's when issuing a
channel switch to hostapd.

First, I tried this on a really old brcmfmac card. This got stuck in a
loop: DEL_STATION, NEW_STATION, TX_STATUS, ROAM (repeat). I chalked it
up to the card being old and unsupported.

I then tried on a rpi3 and would get disconnected soon after issuing
the channel switch to hostapd. No other events came, just a disconnect.

In one case I issued a channel switch and saw hostapd responding to SA
Query requests about once a second. But no other events came on the STA
side. The card/FW seemed to be stuck in a loop sending SA Queries once
per second but never issued a CHANNEL_SWITCH or ROAM event. This went
on for about 5 minutes before I stopped the tests.

If channel switching is not supported I think the disconnect behavior I
saw is about all that can be done. As for the SA query loop, that seems
like a bug to me.

Thanks,
James


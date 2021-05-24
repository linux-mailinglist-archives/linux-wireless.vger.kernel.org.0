Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4373938E653
	for <lists+linux-wireless@lfdr.de>; Mon, 24 May 2021 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEXMLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 May 2021 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEXMLy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 May 2021 08:11:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386DC061756
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 05:10:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i9so40334194lfe.13
        for <linux-wireless@vger.kernel.org>; Mon, 24 May 2021 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=C/nhTHAYAtEXBCGIS64qK41+M8+DoUHptWod822QZiI=;
        b=deIg+QF4dRcUjjeRfLYdLU14NzCTEGKMgD4Jl5Xb70C4FAL8Rty4ajqVqXsBLRb3r/
         I//86duLvLGWmJt6ZbbYfsgGbXFpeFXnCiMdekNDhCgA63YnBvibIAEb8mynMNo6+3pA
         VaTWqdlj6/ZugRg6cJEYrBpwEMTQ/cEY01yTf2a2SDjwpCB+hjL9MzMlVje8VRk2ehus
         g6npazUcgasU2IF/RuJeaJGEQyt4niHist8Syqnfj5aqnbqNHneemxKyH8IujX/0SJzo
         WlRvUH5tlr5nFYXKUDgUdPM9a92URwlQETzRc5tcyCxG8pKRHq3F+jdw4Lp+5ah88oq3
         s2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=C/nhTHAYAtEXBCGIS64qK41+M8+DoUHptWod822QZiI=;
        b=jC+ZOVNO1/YEWYBTaUoZfH2w3hGgP48cP3Kk4v4/daAwazukDjJXvjuQ9g83Gi3zSY
         uVnspXCdh//VrHDupLzoeG4rja5c8Er06YWBULJP/u8m3jBSRElgpZZLhGj+U6bCMspA
         ky8QJN1mlzVtLNnYU/lw9TLxjD23bCkGw8DcCoq4mI0nRJ7VhAhaQ/l1w5DqInpCOgO7
         qmzH8QXcTnUxf2OtZLF2UZha5UOzHF+ieCHQUWTFiV9e9KEmk3+03NdkkIh7lWttEo8G
         pd9RikgAu3+hsm6o3Wc8sPLnD6j2z2t6HuGLKYxjJIf4ViHe6lbhTFAJ22bvzGl+MCu3
         PUWw==
X-Gm-Message-State: AOAM531TTHlMcpiI82lq2ZC7Lp2GQhD0kUwr3lC5Ls2Rwiit4QlJX4Ht
        47DTNJJ2KNV/TIHpRJrNVwR6mGTyuiBlwgI0uqTPOfTdzMDCsX3UVMc=
X-Google-Smtp-Source: ABdhPJzBi+vka21AysUvNNLkfGr/rvhuZRkK7AQz26NIg1fNWJsGccQFmG88Q9jeKAkzttruStT5Mjgyt1x+HOL6mzI=
X-Received: by 2002:a05:6512:3196:: with SMTP id i22mr10405998lfe.492.1621858222425;
 Mon, 24 May 2021 05:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   Bhavesh Kamani <bhavesh.kamani.wireless@gmail.com>
Date:   Mon, 24 May 2021 17:40:12 +0530
Message-ID: <CACrnO3trnUTj+vsi3BGtR_HqR98ppod8thY76XFLzdc5SaXJ8Q@mail.gmail.com>
Subject: Ath9k : Frag attacks
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

I was going through the patches listed here :
https://lore.kernel.org/linux-wireless/20210511180259.159598-1-johannes@sipsolutions.net/
From the patch names it is clear that patches are for ath10k and ath11k.
Do we need separate patches for ath9k driver or same set of
patches(available in above link) will work?

Regards,
Bhavesh

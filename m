Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F91E911B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgE3MOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgE3MOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 08:14:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8EC03E969
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2020 05:14:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so1157965pfd.11
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2020 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acquireprospects-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=0sKF/4C2u1k5DXhLpj853avz1HI5QqO5m9Yc9j3ZDfg=;
        b=Nkax7AqPiEYHi88yikUthLFshwfv5eWof56mKBptFHvhg9ZJmhj+BAefdzo1QC5tMn
         IfZk2r5XyNuP0qECROxr7gpDbkMMycaOsf1DmcQl7nV2Be3MycrKgb/lIVYKTQm8gO94
         SY/O/tmolBijqcog2b8kJGrbs0TDP/1wk8rdqmDt1Aa9qhXfSW0nrF+6+vQC9UcegIH/
         y16s1YZ8x62MuhwHLbNpNU27q+nVU/uvGqzvFYsLmu+9M68BwFsXDKoCz7LMfBPiSAXi
         y9gaYz0o56+QUCny5owsLjUWWuh4AiRvugDvBnA6Ewbwpkdr+XjlxrrZj978Zs2F7oKv
         u2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=0sKF/4C2u1k5DXhLpj853avz1HI5QqO5m9Yc9j3ZDfg=;
        b=uUm7kMVq6h22+5acsPP21fXvxM8SQLOy+fUlPCMXqAz5E/iRqm37ccF47/MQL3gilX
         E8TbHrlWgXGLqiT3ZYv1j5rczv3FWciw5l+wpFxBorVlXv7oYXiSPe2QNuvWXHB3cL+J
         Xw0tckQIXwdtc8eranYhqGyct7ZTVnaTZGHVM2YOsh08WvOVDXGdwMpU7XGh6+S2VqUf
         VbEqwcyU+3Xd6qzJJmmFI6gt63ixlvklU1CoFLtAUhJZGeGAeRZz6LMojcD6PqAM8ZNh
         V58hq0/KI3nhPKgXh5AaSLBENnrM4/BR7U0mAMtJZj2LmV9THHvvSgI21W8bnv09vfrU
         S13A==
X-Gm-Message-State: AOAM531pE/4yIWlYQ8jtZnHApi0vLkFbkyzLTF2F1KWnZfZzDV52bEBz
        eQ2WWe9C0F/OEprOJgX9XddKDwjcZGE=
X-Google-Smtp-Source: ABdhPJwrSwm2Dim2jWgCJTenprOcBgAB+5LMp2+vIfejyEow4FkqhGyFnblJNQQQ+5F+nsv5C/BXxQ==
X-Received: by 2002:a63:a51b:: with SMTP id n27mr12577996pgf.40.1590840882135;
        Sat, 30 May 2020 05:14:42 -0700 (PDT)
Received: from hh ([2405:204:5183:3486:942d:510c:af32:fdd0])
        by smtp.gmail.com with ESMTPSA id co16sm2178491pjb.55.2020.05.30.05.14.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 05:14:41 -0700 (PDT)
From:   "Rachel Lee" <rachel@acquireprospects.com>
To:     <linux-wireless@vger.kernel.org>
Subject: European Mobility Expo 2020 Attendees List
Date:   Sat, 30 May 2020 05:14:19 -0700
Message-ID: <005601d6367b$e6fc4ca0$b4f4e5e0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdY2e6Zp1S8xE3uJTwS298rMtQF4Gw==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Hi,

I understand that you are one of the Exhibitors of upcoming event European
Mobility Expo 2020 held on 23-25 June 2020.

I thought I'd check if you are interested in acquiring European Mobility
Expo 2020 Attendees List for pre-show marketing campaign, Appointment
Setting,Networking and various Marketing initiative. 

You basically get to own these contacts, no limitations on the list usage
and opt-in contacts. If you are interested, drop me a line. We will get back
to you with pricing, counts and other information for your review.
  
Thank you and I look forward to hear from you soon.

Regards,
Rachel Lee| Inside Sales, USA & Europe|
Email: rachel@acquireprospects.com 

"If you don't wish to receive emails from us reply back with LEAVE OUT"






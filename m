Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF6C05EB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfI0NBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 09:01:31 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39877 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0NBb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 09:01:31 -0400
Received: by mail-lf1-f48.google.com with SMTP id 72so1855239lfh.6
        for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2019 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bm53GEC1bxeQetuvvHJKmvDvtpSmxqo8HsXwhpJDzTA=;
        b=KzwJYQqHUzVUwGbqMvYh4y6hDB5x+nwNgAQSJMb3aJxYAsX9G8PZFXPCC7CVbZ3jCe
         F4cVHN5zgpqvsnmgZ6T2e6fvMDZgA8PzyvodfzqNgGFAHy1xOOnAICDzXfRq1mvkTC/0
         lqb0NH+XY5hKsBn0SowyK4yOP9otMHP3zU4zAtv+U7ntQl2FIAgKuUITYv3gPOQpb0iH
         hc8EhoTWu/9w1MfaZAy7Cob+qNHplvsfm3vWt9So+2Cb1UcbBf++Lj5mgHFWulyEvAzi
         +hEYBv+di2Zv3sE7gp94SKz60/BTdrqq/NOwLXYTCAd4TMJxU0WYGmL0OJ2epa6U0IqD
         Vx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bm53GEC1bxeQetuvvHJKmvDvtpSmxqo8HsXwhpJDzTA=;
        b=DL2KHq9fYwRc5i0B3xOPeopGWLG7mRElJmCRhRMdanSO9LtQ91EgEXL5HFT9SP6J0L
         SifQux6vnsBoEYU/BeidUnbwn/Ri5jZLUmqbtr/tekx1zckJCwFx9cT1S1Bi29j/bk1O
         LIcfji8Hj4JcuxVc//14j2r166cfOq0r3KTDTqL42uM5odHT4CbNYf9UN1ml1+8GtM6Z
         5NeZB3tTYEkqLqm+qsbwMKZzYBXuBfBPP7VzxRFRwIMyPvnyY2vlwqUYuzPQvRxLHcQ7
         xNI8UFS3NDo0SEbBZEky9zwh/r9lj1uNXosuEmh0tuREHWWgiaPH96KOkwH/giMlAJiF
         cOIA==
X-Gm-Message-State: APjAAAW99xxIaDCGzXi53wN63PO+OFgV2M0YQXVHxdaaAvltyBX7CA9+
        ZRbX6gPzXKVq9x6+FOkEBRNLPTkbbV1vVD1Qp28=
X-Google-Smtp-Source: APXvYqxF2+yfPstS8oA+BGpRXMXZHASGQEx8B4g88+8pIEiIBeZ0f/IxQlNHXx4M3jh1ScHOYFAJhUXvTGa8F5yFC/4=
X-Received: by 2002:a19:7715:: with SMTP id s21mr2664956lfc.98.1569589289159;
 Fri, 27 Sep 2019 06:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23ZyFnYt+ePreGjFA2VFXnpu21SPthscvJhP-5xjQCb0OA@mail.gmail.com>
 <49ded6ae8a23c29168ab7061235292ac7a853e0f.camel@sipsolutions.net>
 <CAK8U23bdmJGARCT=TXKyfknhmz-V0qUJ8dj0Mhko-CkvW+uW1A@mail.gmail.com> <6d62fe25faca3c000964e4f712bf3ba2d974d2f2.camel@sipsolutions.net>
In-Reply-To: <6d62fe25faca3c000964e4f712bf3ba2d974d2f2.camel@sipsolutions.net>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Fri, 27 Sep 2019 10:01:17 -0300
Message-ID: <CAK8U23bUjYuG2=trtuEpcYT1xL1+kTugWrQKi=UTuMnFN-XDSw@mail.gmail.com>
Subject: Re: mac80211_hwsim: packets being transmitted through the monitor interface
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> A monitor interface created on one of the (hwsim or other!) wiphys shows
> all packets seen by that device.

Weird. When I try to reproduce the same with a physical network
interface, I can see no packets. It only shows the 802.11 protocol.
With mac80211_hwsim, in turn, I can see, for example, TCP packets and
their headers include the 802.11 header.

--
Ramon

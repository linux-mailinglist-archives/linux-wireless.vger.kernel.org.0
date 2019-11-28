Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17010C5D3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 10:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK1JUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 04:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726181AbfK1JUI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 04:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574932806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMQLwfh4Xn7uHSvAxxesfigbng9gN4jTKpnO3NtkwfQ=;
        b=i/BktNouwtkHKyzAyrktcDKIbWjuuyAyWOT42RIbariQtd651KRTFdMOMkCNQQ+rkCK7Ei
        FGvxhwEPjF5qXx+vSHK1pZ4M2lx/rRc+CAjsWIiT5S5VOap/ze8q6YRIbTtsJMUurMsPic
        n3ZgFD6Rysy+zxVJxL8NcouXoLPKy44=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-UZXVYyZzMxm979LJfW_2dA-1; Thu, 28 Nov 2019 04:19:23 -0500
Received: by mail-lf1-f72.google.com with SMTP id u17so5429450lfl.9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2019 01:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JMQLwfh4Xn7uHSvAxxesfigbng9gN4jTKpnO3NtkwfQ=;
        b=IkYZz9INU/wHzcI95eL+vStwYXu3CsUCOXZkrPiH7aV+TfUmdlQjXf7GJW2R3kLhvR
         ExiKdAVCZaPJ7RL4H9c6WmRXWfBo1s8uEC8QTV9FBrKne4B0G0MUm13a0FeP9NsbNVA3
         Mvj/iac/D50iXYEUzeB6UPbqFwYcItGAQvv9BY9GQwkL0fzZRpOffxKxHaNXBGO8H4nN
         lNP7CSHjji2wyotGEmL4wgEPhJOA6j2tQmfwB/Ydq2WfHw2cJYQsnRVxptmJLuWRSpaw
         RvsN8yLXsUQQN7ICMA5J2/p/DW6AzO+f2G2V2yIM6XspnKog7pN8SPXhMmcijC5ody+8
         LgWg==
X-Gm-Message-State: APjAAAW3Hazd3qtuZyRcN6/KnZ0lc6Ls0p0AGh0SlCPvjyhALl25Jn8l
        NV+6uT4G5yprzrADcYeRJcWyIpDwOGFhshrQpSYfYkPzOjDdxrAORrPcgfAM7IrU2kcSlIP+1KM
        eKYnJ7TYYda4r29Au0REcGOFhaTI=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr9085429ljg.249.1574932761833;
        Thu, 28 Nov 2019 01:19:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzZ74/uja59Iejn6g1blK/7U/cFXQP27bKOB5IYSZQeKMv8tEy73cFkrWxj/FUKOL1C/+Zhw==
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr9085421ljg.249.1574932761700;
        Thu, 28 Nov 2019 01:19:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d5sm8281763ljc.51.2019.11.28.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:19:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4ED3B1818BE; Thu, 28 Nov 2019 10:19:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kyan@google.com
Subject: Re: [PATCH] mac80211: debugfs: improve airtime_flags handler readability
In-Reply-To: <9df7e40b45e95bb0b320317831455beaed1ee3ee.1574872357.git.lorenzo@kernel.org>
References: <9df7e40b45e95bb0b320317831455beaed1ee3ee.1574872357.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Nov 2019 10:19:20 +0100
Message-ID: <87lfs0we7b.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: UZXVYyZzMxm979LJfW_2dA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Improve airtime_flags debugfs handler readability reporting configured
> airtime flags in both numeric and human readable manner
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


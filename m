Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAA216E62
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGOJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 10:09:37 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:13396 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgGGOJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 10:09:36 -0400
X-Greylist: delayed 807 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 10:09:36 EDT
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067DsUiK132029
        for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2020 09:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=20180315; bh=TMydR4YKBmWW8YheUujDldBr0oV9xZ3Hd7/awc9Ym3Y=;
 b=Afh/UVFgpmD0NVm7lAnQdNXTSVszsxFMUNRodkBrxHEPveh5vanh5zRkpeTiNacJFjiU
 zWJ6WrK5LnOvVTCQ+MVU4mFDs5fGpxoZtR+YGvzCMyUr9fyY49L52cclOOknwLydK40s
 sGVb7wbFHgdKNe+3XX60USCh+nYhnr8OgsgCT0en/uhS5Kvo3UPVA34eqyO/drJ2GMY0
 Ka90TaHZMrxPmDHqCZOkhF6ci6ECxJEJbzmOrX9wGoBwfCZPmq2Q+PvPmBSLbVB+oMDn
 uj4HNJ85qsJHZcy8zUflyTsKvtfop09w9K4+lNn8QlgRL8sgIDR0b5CfqKO082dDzepB rw== 
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
        by mx0b-00256a01.pphosted.com with ESMTP id 3236uq06mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2020 09:56:08 -0400
Received: by mail-ua1-f69.google.com with SMTP id y12so14744451uao.13
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2020 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMydR4YKBmWW8YheUujDldBr0oV9xZ3Hd7/awc9Ym3Y=;
        b=F1cS8RbG3/7r/Gk43gN33l6KV1b8Vm893d61U0XgFxF4nYdUSx1XkH8Qh0z+tGt1Q/
         BIZU/9Uqa7ZYKkch91X0gw9NFtXdvB8eOREqhimcHSbtj/hKDoLdv1yC3yrooFZVDJj6
         BaXElpXgTwJdCCPI5g1sm5LB3drdmfyC1zr5dm6GsmwSUnlRoHGEy5dIvvxY1tsf0Ybp
         9lSOWeb77yBg881g5HTe7Cj/VBdAvvcwHPNV83fmNwpXzDxSPfpye/koGZJTmDD4UoN/
         QWL6Bn9fO8eUOvyUanoWXY/+IMGOvOaPTajgXNxeFtAey8v6gWFgpJ4YZpBOgf7bZHD0
         W5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMydR4YKBmWW8YheUujDldBr0oV9xZ3Hd7/awc9Ym3Y=;
        b=mYYaKe+HFD1aX0zsgo7X+gCENbNGuf/mEUH/+4lm/1pHInur6mEgTZPEjfO+yqsbqC
         +QEedjHXEiI4DsEoTG4jVN92TpGrq06pXtv6CG/e5XdGO7QK64M0PrBOPNj0R8wGYlfa
         FxVWdoUegQhGgzDvVeb1LSnrWCwm3gdyyD15bIbDREgZ9vArAOs3WXZsVEiGcq5HW7Qk
         U21m1nZyoXwSSNTuZLmzJNtY4aeD/KGdTlILEyxQPa/hYJL5kngbn453nWWte3in5waq
         ImVFklfLqYx3vMXj3Qww6sYv5zae9ZrO8Oq0KsQODGwkAbJA0eFj7zmkLDeIMUzNDvDE
         3VWA==
X-Gm-Message-State: AOAM532kAlPOVlSZj92y1YqsHLY2anlngTkWUCdeF4bJYxx1Y5QUiOvk
        1VLiNiUMj2P0nhO640ceofyh+UjHANHlJuJ/2kZY3Gz3i4t+G2GFYzDLdZN7DDlqVCVJDrnVLPj
        n5PZRzp7oYPlRu2TIQiK53wGluQV0LWhQh7x2/ggZ
X-Received: by 2002:a1f:788c:: with SMTP id t134mr32089919vkc.30.1594130167786;
        Tue, 07 Jul 2020 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFqMsOIBaHbBsSEJwjmvFr+pyVVwqddPJUUtGAAqXGKTcO0D+TaphBkn2lIzCLFgmoCgIjMjt488pEjMFUxYQ=
X-Received: by 2002:a1f:788c:: with SMTP id t134mr32089903vkc.30.1594130167587;
 Tue, 07 Jul 2020 06:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200628220512.28535ebc@mathy-work.localhost> <20200707134523.GV2549@kadam>
In-Reply-To: <20200707134523.GV2549@kadam>
From:   Mathy Vanhoef <Mathy.Vanhoef@nyu.edu>
Date:   Tue, 7 Jul 2020 17:55:51 +0400
Message-ID: <CAJg+V6msadZ+Qr60p4iMgeSFN13MVFRseX-TPeVO5xaNbDKmkw@mail.gmail.com>
Subject: Re: [PATCH] mac80211: keep non-zero sequence counter of injected frames
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
X-Orig-IP: 209.85.222.69
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=808 suspectscore=1 adultscore=0
 impostorscore=0 cotscore=-2147483648 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070104
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This is wrong.  Also != 0 doesn't add anything.  It should just be:

Yup, the disadvantage of late-night work. Hence also my follow-up mail
to drop the patch, will send updated patches at a later time.

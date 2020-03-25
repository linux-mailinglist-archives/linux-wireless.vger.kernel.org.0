Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF48192BDC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 16:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCYPKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 11:10:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44397 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYPKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 11:10:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so2830991qkc.11
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8jFKyQqn/EJM6A/QfYo4XLRwXVxJAgYZ7ZuhF5oD5Uk=;
        b=qZA0b/qkrorZNjCejFCxurQ54X7r7lfbrYTWBJmyzwJaWzaloZwNMp9N/a6OKcIF0N
         u+D7XexTXLEVd2uROAIp/99/7+nYB4awzi8epjkvL0/clJljMIyvtv02unQzwiG+iVxX
         ZjdYzsqshR9bJSEmnQoQw4WGSjN6B9adtT6BlzTqU4De0e8ZemUtORm68cTy+/duH9ug
         rJEVJXfBmm2RP2H+RpspTydkWxFHMT5AgBh1WE98oolAm6Z0bhoEB+O3cLqA93EDnAAf
         UGIUv8vlb5TokY5CrtrGEWTaVCPOupMMWayXmGvZvGnc8wNaA3tgugWdEsqaShDv0ldH
         j1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8jFKyQqn/EJM6A/QfYo4XLRwXVxJAgYZ7ZuhF5oD5Uk=;
        b=WyEsxfRIkLHY7JWuIOq/xuN21liiljxbU5h114tOiGM5sgMN812inF0iiDUjXvS8uZ
         gGmUHhbjlTHJurIEGWlLwBd6S2ABCgnU1gn5zznPef5pX6I1G//+khDjSDOI7GbwYACm
         qZZT2QqRrycBDw0dWDrOCj7bk0OTHQBHYBbat8NilyfJduG8FI1mS8gnvTLREhp6TzOC
         HVfzABqq6MXq5p7pvvxLLBLkeCJGKkfPps1A+dYj8ADEU9LWvoQsVFThhVp0ZPTxRxJ0
         XAPTBHmZyBkHOwP7dwHntFqUrTWvmrsAewMrJd8SeLpMOAdTaCZ2XtB/BC5v/zKugOly
         xuyA==
X-Gm-Message-State: ANhLgQ045qXiHs8ORKCZAG2LQebV0Ouzrldbo4DQ6lyfznQEY1z2U+g5
        jZQgnRnV0fd1Y8f4LCtjRm8=
X-Google-Smtp-Source: ADFU+vtF/poG6pEzSj7Vjv+uADNeeieVYuyB2i589fI79URBs6HbwLjuum2B+3BG44nuzYfJxqdgBw==
X-Received: by 2002:a37:50d4:: with SMTP id e203mr3248715qkb.153.1585149013091;
        Wed, 25 Mar 2020 08:10:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8d4])
        by smtp.gmail.com with ESMTPSA id s188sm12706336qkh.67.2020.03.25.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:10:12 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:10:10 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Wright Feng <wright.feng@cypress.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a
 module parameter
Message-ID: <20200325151010.GK162390@mtj.duckdns.org>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <20200324182358.GD162390@mtj.duckdns.org>
 <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
 <20200325140814.GI162390@mtj.duckdns.org>
 <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 25, 2020 at 03:53:43PM +0100, Arend Van Spriel wrote:
> On March 25, 2020 3:08:18 PM Tejun Heo <tj@kernel.org> wrote:
> 
> > On Wed, Mar 25, 2020 at 12:29:44PM +0800, Wright Feng wrote:
> > > If that's incorrect, would you please give me a hint how to set
> > > __WQ_ORDERED(internal use flag) and WQ_HIGHPRI flags at the same time?
> > 
> > Wouldn't alloc_ordered_workqueue(NAME, WQ_HIGHPRI, ...) do what you want?
> 
> That was my initial suggestion. Can WQ_HIGHPRI be used together with
> WQ_MEMRECLAIM?

Yeah, they shouldn't interfere with each other.

Thanks.

-- 
tejun

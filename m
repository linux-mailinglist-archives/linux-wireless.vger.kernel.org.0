Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F431157ED
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFTtS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 14:49:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33983 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFTtS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 14:49:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so2048814pjs.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2019 11:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKTauvYmu/HzA8mbqSwTd1wp1lFbRJsDBZQvR6lo4Pk=;
        b=RXChqlWkxNRtCrwa+M/Jd4obxGO1/ZTDujbGHYlGElRxQEM3gbOC3GyPgaQfpaKDSj
         yyn/BvWbbM+KsZRSoj7Uwj5/0HpTWcMDFFVzZOilJo2kJzPTqBRWE0n50MQsmTemXiFc
         nHZg/GqmWhcKJ/q20XF+adp6NNdT3tbhGeJX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKTauvYmu/HzA8mbqSwTd1wp1lFbRJsDBZQvR6lo4Pk=;
        b=R4CnkURbALbAwQiVoi4AjatkEHvprVRO5mcdT0L+MRb9W9OZQOicfsG0/cCXUCyLL1
         /wCGa3I5OfniaSzqJwtlub0AfqlcuAeEbal13SkvMhNNA/RZtPPQA76tKw/OpeSEDu5D
         gjzvM6uFduZJxkqUjHOxsHOC05opby8eCZDP7Flufix9GUiTh3yA3hT2P66yS5BdV2Cw
         uXb1szT18MYCmFtIwCJbpjBtZjeC3op4KM+/K+RG++gH8YcSGEaYCBMw/geoN031DeB7
         iWeXExAQ3aZACOpLj4PPOYj/yGME84PLiqJJqZwlayIo9PHf9maOFXfPmFEk31at5yxm
         az5g==
X-Gm-Message-State: APjAAAXQEA4G+sgXJlYZo55UU1Gxk5+xMndah1PbkGn948SSjtT4Pjr0
        ssrDFqtbXaxGqmFim9Cs1GG3hg==
X-Google-Smtp-Source: APXvYqwnyds33ckZocFtQfDqJA/m0ntaAH75/+43y2/U4QCbOc/8i3ROuNp5RA1teaFCGF/8yCpQ0A==
X-Received: by 2002:a17:902:9005:: with SMTP id a5mr2880589plp.194.1575661757699;
        Fri, 06 Dec 2019 11:49:17 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id h3sm3851768pji.16.2019.12.06.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 11:49:16 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:49:14 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, greg@kroah.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH v3] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Message-ID: <20191206194913.GA151147@google.com>
References: <20191129101054.2756-1-wangqize888888888@gmail.com>
 <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXOj0rz4S3BoMdF1pqOiVZ4yhVE_Qy+s6iTObCnhFfwFLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 02, 2019 at 03:16:35PM -0800, Brian Norris wrote:
> A bit late, but a few readability and maintainability thoughts:

I worded most of my suggestions in the form of a patch here:

[PATCH] mwifiex: drop most magic numbers from mwifiex_process_tdls_action_frame()
https://lore.kernel.org/linux-wireless/20191206194535.150179-1-briannorris@chromium.org/T/#u
https://patchwork.kernel.org/patch/11277011/

Regards,
Brian

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523962E0D5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2PQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 11:16:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45504 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 11:16:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so2363357otl.12
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2019 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Fruc2zAug5V7V7f1yxXOmy6rMbflb28X5dis5orB/4=;
        b=unut4nAvSFEG9tx+1s73chc9j5I23jCPQqQbFcvZlR8pVyK6d3Sj00d+piaYZGO3Gn
         qxmT6P9geIQ5l2GYXS7BFyMFZhqtz+qKqsUnT/E4CRPBiHR8lZ3XpF04QqVipp0PNv+N
         pg/gfn6RM2D0rV4a3R86XSsbNl3K0gh3xuPPTrKX3TeZdPt9vVKQrkz2O9g8Omj2jofl
         /Z4gd7LaJ7Zs+jjGZAob2DQqI+J4nOlHeAF7yqY1WjHfjLfBG3X1n/d3YL13uN57DUAJ
         3TucgysjtLeSMfTyjY7C3iBzpp3I9UK1i43S2GlIWD5lYxOA5kETOu7fFkt5HVS9UyMh
         fa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Fruc2zAug5V7V7f1yxXOmy6rMbflb28X5dis5orB/4=;
        b=od0oXb1JvtcdGJYK7IhDtYrnXHVUZaAE637o1G0j3LzNZBpXi9eu09S30zYBgRACq2
         Veqr2NrjOsP/x3Qcg+NjvTtmxf8vfndV+66q+uDafYo5IK+quNp1I6OAHwn57kxPXfPl
         QTxYMs04+ukfftALZmm+OWDINV6AEOQtkrhQ/NpO57VHaNtsQ0gVbFLQW5/N5keNbMbO
         vOJ2sxxwrKjsaTbYJNONaucOr/aT3nUdtF5SrHiITJL2g8M2ATlpLPpmk9wQi3I4Kz1b
         Qn8WE+fAnQkSc+XAc4EfSiHJD4aycktZ7L7RlHqAqNL/sVgbgO4HxxgZ3LOfc1QGSa60
         R23g==
X-Gm-Message-State: APjAAAV3VX1wenkvQ2mvSm8Nlvo0P95pZiL+oFKm5+JXyI4XQW05mwg8
        ++cdXT75qK0uYrn3Ee0wzdUfozPW
X-Google-Smtp-Source: APXvYqyQlQh+/cSgKiOtbciqziPQ/eynea7MIl349vBvIbTi0A61NtirFd9oEirhsYSFwl+5j3Yspg==
X-Received: by 2002:a9d:1405:: with SMTP id h5mr8619863oth.118.1559143011750;
        Wed, 29 May 2019 08:16:51 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t21sm109715otj.46.2019.05.29.08.16.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:16:49 -0700 (PDT)
Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
 <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
Date:   Wed, 29 May 2019 10:16:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/29/19 2:54 AM, yhchuang@realtek.com wrote:
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some functions that should be static are unnecessarily exposed, remove
> their declaration in header file phy.h.
> 
> After resolving their declaration order, they can be declared as static.
> So this commit changes nothing except the order and marking them static.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch does not apply. Using quilt to see what is wrong, there are 6 changes 
that have already been applied.

Larry

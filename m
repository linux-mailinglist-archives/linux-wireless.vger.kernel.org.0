Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2227925A8D3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIBJqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBJp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 05:45:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693AC061244
        for <linux-wireless@vger.kernel.org>; Wed,  2 Sep 2020 02:45:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so4494875wrm.9
        for <linux-wireless@vger.kernel.org>; Wed, 02 Sep 2020 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BR8xymaa4iKP9zRBrZdl0waf4dXVlbO2ckMe1X9XNaI=;
        b=EHzBQfDU6/a9cYe+Zwlw60m8qE8KIPnEtNuRamjw5YKyxpTI8RSLizGSUM0NwxoWDG
         oslec12xN5Zr3JIw1FroVpJEGRT/orKNTEHEbki5WgsVP4hctZIwl1laCcLP3pMvJLA3
         dPW+MvuoNmqdonpNSjrIicgM785nYSRMOEpPKpruFtudaVP5WmdVhQXG31bBNkUsTcxB
         cCDxFKS0cZB2d/7saC3T0gahe/8ppK0LDK5wOolIHzDOzoKrmKOOcLlem1dRFZiu91zt
         eHFMuycb5wsZ43VJMpLwRzfF8++uHPw9bfhaUmJk/FTOj76bNxx5jO9biht8Mr6+GHLQ
         +J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BR8xymaa4iKP9zRBrZdl0waf4dXVlbO2ckMe1X9XNaI=;
        b=rWdTqA981ripMApzw3IGZjqZ9tDUm3m5JxZ3D0g7SDcqGXDTkYmBEru0Dwg5tt7aO5
         W1dsW4WYfu85VHqt/gkTQ/zRb7hq2WJAksaOUN5s9ZFXquLRMPzR5zpMFf9pJbA5URnz
         IqK9BBhQU3WGyQxtl730iraj9xRycnVCRoWFVZbto92iNift+Rask7S+HkYgUJ8ezuBm
         S2NpzmOSzkw3xDt6b4zhk9cGBjoksPU8h2AW+pWMLEtZqDcA+drE8dfxave/MD+p3TrT
         B0nXg3I+TqRnRbpFbGOCjMzYrq/zCDXdMXVl3/JiKrh8pZpsZd66PhZNgE6pk0EwbKQG
         bH1Q==
X-Gm-Message-State: AOAM5321KyU3RsgZP/OSsEsDKV8vsH2QhQksXTrHEZrhdWe6w8GX/THT
        eBZek7/5Xv3voF3qIR3jYFR9vvs42Milt25Q
X-Google-Smtp-Source: ABdhPJxUonq5sbEwdRHyFq22xuHXa8p1nyH//5GR8Y6T6ZiGP0umlRBD9gfoCvjZI4UaOr1+5inzaA==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr6195768wro.126.1599039956560;
        Wed, 02 Sep 2020 02:45:56 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h8sm6326507wrw.68.2020.09.02.02.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 02:45:55 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] wcn36xx: Add ieee802.11 VHT flags
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
References: <20200829033846.2167619-4-bryan.odonoghue@linaro.org>
 <20200902085545.5CC7EC433CA@smtp.codeaurora.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <0b09678b-0966-09f1-7e83-252ad1bce25f@linaro.org>
Date:   Wed, 2 Sep 2020 10:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902085545.5CC7EC433CA@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02/09/2020 09:55, Kalle Valo wrote:
> Fails to apply. Please use ath.git master branch as the baseline.

Oops, I did this on ath.git/pending

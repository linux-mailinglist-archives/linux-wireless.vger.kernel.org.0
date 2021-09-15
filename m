Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3404E40CCFE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhIOTGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhIOTGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 15:06:04 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4BFC061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 12:04:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r26so5593380oij.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JKkOwZuvZKIeu7efGajXGlD+snfoAf+v8fNQmncZFXc=;
        b=tGoVyX94TJeanqGxi3PM2Ukp5wS61jqLDIb1gp8otWP1mAL946xYOaBqOI1XeTiRAd
         MEtgFRLb3wcu1RCn3nr9xcNZno3V6fMo2gCTOGpOtwXJyWvCG15s9lSdw8ofPMkqW9cp
         3r4gHO9nsLU+8+Y6kmjfSI55ydwTfKn8EcRM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JKkOwZuvZKIeu7efGajXGlD+snfoAf+v8fNQmncZFXc=;
        b=lMiwrLlXHCrQBQequOD9JTj4YgDyH8c5xMGExjEcZm/hwY4eeMtMd7mEXA8HC2s75p
         n+5bLDQfGIqR9WmVsqlxaYbi8Cvl5gJByULEsRbbmuu5NJMkb+nel6RpKa84jz1p7twR
         zOBfszR+inGw+YD9sj/LwMBkhtiuzFea2RZ2r2fnwA9L981k/TGusQyMROw8ty5hvTaB
         ITEi/H9DgaLXSFkOhCx584DAT+mXWf6LDqI9VfmU963SfodnPcEy3QgnC8OY5PVrlXBN
         Lht+pmsl4ZqVp+pzPf3oHYM2+J2F04F/5OmfLV2Eh3Ag6k7xzjy4adwFY60dOCYldL8s
         ZNsg==
X-Gm-Message-State: AOAM5318aMjFeiY878SGNj32k68f57nTUWANuuC1YQHZd4dTPCSDSiFy
        ry3u/vvjhrip3LkzaWxlANp2ZQ==
X-Google-Smtp-Source: ABdhPJzLvAnKQxliQBVfQy/2cMv0B1nlzK1X2skFE6KLpS9d/a3Yjef9kgs4SkJCsMShms3mb0mLrQ==
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr6527395oib.39.1631732683773;
        Wed, 15 Sep 2021 12:04:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:1e0:5e11:1b48:4db0? ([2600:1700:38c5:675f:1e0:5e11:1b48:4db0])
        by smtp.gmail.com with ESMTPSA id z25sm220545oic.24.2021.09.15.12.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:04:43 -0700 (PDT)
Subject: Re: [PATCH] ath: regdom: extend South Korea regulatory domain support
To:     Peter Oh <ebmajor.dev@gmail.com>, ath10k@lists.infradead.org,
        kvalo@qca.qualcomm.com
Cc:     linux-wireless@vger.kernel.org, andreas.tepe@debitel.net
References: <20210915185611.6195-1-ebmajor.dev@gmail.com>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <cf9e7515-edea-61a5-269c-10613db15e19@eero.com>
Date:   Wed, 15 Sep 2021 12:04:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915185611.6195-1-ebmajor.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/15/21 11:56 AM, Peter Oh wrote:
> South Korea manufacturer, Samsung, has extended South Korea
> regulatory domain pair with 0x5F and has used it for their
> devices such as Samsung Galaxy book. Hence add support
> 0x5F as a regulatory domain pair along with extended country
> code, 413.

I don't see a problem or conflict with extending it.


Thanks,

Peter


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA01D9D60
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgESRA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgESRA0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 13:00:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF6C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 10:00:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d3so155248pln.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cKdjfyyA7qf8ROemM3hzhUcyRED4GcOBh2US7y+FSXQ=;
        b=U6DT0qDqJ3/HOnv8xw114x7cQ6rRDgaixhHDsB25ErqpimE0Iic8Fss9sowsNKOWVi
         XeLkVC79VyLFzjpDBwWRV1QiCHhH8OFfNQE388VXQX2BDQnpGjxdJZORN7EW4I48YW/d
         ynwiFmDy2m+JuFSVL3IkQgRqS8W5mBbWSbYss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cKdjfyyA7qf8ROemM3hzhUcyRED4GcOBh2US7y+FSXQ=;
        b=VT2LlqA9iTrVS9LoWVu3ujV1pRP86pXpGQ5IDU+aVbhEzYIixK1QY/oLqxq7OKopyN
         JAgg1g2X8SIZECxZR4/uHWB+N7lObNRbNr5ahNRQ87rP0sA8Kz0/J91MVKZ4uD8fJDV9
         RGEwysssXqof2FI3PP9f67ldxth5otu9QRZp+8ww+pHohmsEcT61QtoMuQqdhQoH1+I3
         3UMbtHxrMyqrK2qPs1JzdmsIiPcl9k/HdT8VgE0kbnoNdrer0qSPlqxc2tkTvTo/5QAG
         m/N7MA3T0Vg5uDp4dV48TOnkQ972hcKK2ylspgZZuKwAVDhxuZBVp8smrGZGXpsNm7Df
         4zPQ==
X-Gm-Message-State: AOAM532uTJzHTC0aQ7EfyE099D6QMvZUuOgAxzU3PF6cB5SGYT8eoVbj
        mF9r0DM5bRcKnKLMk98WsbyVuQ==
X-Google-Smtp-Source: ABdhPJxYLrCieQRItnAJxB2V3/FgjpUo0jQclvXEpr82rFmxpVAIYW5KWbpCwM4NmJX01UBULFnV6A==
X-Received: by 2002:a17:90a:cd02:: with SMTP id d2mr468495pju.207.1589907625998;
        Tue, 19 May 2020 10:00:25 -0700 (PDT)
Received: from [10.230.34.187] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 189sm58412pfd.55.2020.05.19.10.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 10:00:25 -0700 (PDT)
Subject: Re: [PATCH 0/4] brcmfmac: SoftAP creation and dcmd buffer size
 changes
To:     Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
 <87zha4do7h.fsf@kamboji.qca.qualcomm.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <09bf3506-2d25-d8a8-43eb-59a2e3d9a9ae@broadcom.com>
Date:   Tue, 19 May 2020 19:00:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87zha4do7h.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/2020 3:54 PM, Kalle Valo wrote:
> Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:
> 
>> Allow SoftAP creation via ioctl from test tool; also update dcmd buffer size
>> settings for new firmware. Also fix a sparse check error.
> 
> What ioctl is this exactly? Wireless drivers should be using nl80211,
> not any ioctl interface.

Hi Kalle,

The terminology is a bit off. This is vendor specific command 
interfacing directly with firmware and the content is opaque from driver 
perspective. However, a number of these commands have their nl80211 
equivalent. Especially regarding creation of AP interface I would simply 
go with creation through nl80211.

Regards,
Arend

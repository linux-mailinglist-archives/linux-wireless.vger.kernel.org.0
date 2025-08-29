Return-Path: <linux-wireless+bounces-26875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034BB3C451
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 23:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBEF1CC14FB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58925EFBB;
	Fri, 29 Aug 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHPvrkBi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D81B87C0
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504006; cv=none; b=n8H7nmJhd4LEsjBUmiXSyWYpOEdqTW5JfIWX9dLrD8EoHGFaXdQhBcqOKT55rgxrLkP+iOZIyDYG8Cxug4D6PFIu3vhY/j5ECkTc7WUOU+Q3xAbfbVe+b9kA4hKDfvVrXk1zN+6tbs7OjIzwDXNhohz8JLNnyIihZRCrhIRCeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504006; c=relaxed/simple;
	bh=yCBwvdDv5xsKbp/CvIMs/+Mie4o9idAfzGQ8LLjm6GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DO666x8yJg1WXuiSp7XgQdzpYUM290aKDRqUhPD14HjMeQjc/pSLp4hpWxezmOji2Qnz7NTfGzVAjscCgHr0ahjfj5u6mJUSGUT9BIHa6sETSo1tZVOdi+brfcOyFgvNCpKh/uOtYlNVxrYD76N3o2IbIvsG5JDr4+9swUR27rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHPvrkBi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7d497abaso14540865e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756504003; x=1757108803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4ixxDlBzKi4nXPDYUWPjTWZIJDJuqpM1CPsQQOkTbo=;
        b=jHPvrkBi6f+I8clPZU4GX72Ybdfg5JAoA6SrAGhbmskOrliFU3jtld7c99gYnwMWXV
         eU4zMo2Ehnq+vXtqiu3yK2zb6S99aW1sDqLB+8NapGjHcDjdRM48F76qQiw+CW0Pzs0h
         ccvuwDVoQtuClaThR8cSpq5W2n7BoGitnYcnT7C4UCuMustnP+36S3I0U5O94DwTZa+V
         Vg5NOq5/LbiMbXaC32olA9Yw4v7L4x19VZd+mpwe3G2cWfwcdJDdTIez5PgG0gGqDOu/
         JQM1/LoVJFaIRfNW+ThZB0SIB6RE7SJUtxTtD927HlHLRJuk/HJMoukZcaySrmPAoHO5
         wnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504003; x=1757108803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4ixxDlBzKi4nXPDYUWPjTWZIJDJuqpM1CPsQQOkTbo=;
        b=csWM0SumDQnnphjj0J7eD6iBugsCx+OtcYaFi9Zhwp/VBOTarsAFHO4uD/SOeQwCAH
         UthLJroBcRYT5X4nk32ww2tpG0Cfz7bHR75oASA3OA6VvIyPLcWD+UY4wh0xbCo+Ts2o
         CUpNwH79r122V9bQ0lV3MWRr/7clVEud3dCWUvU5jQ5t557FLhWMjxZNtE3wDXPRTjzc
         hveo0/aOPbFq+Rs587rcgrYw6HLCo9TKglS3ChLm74GyPfZxoVvjwzYI9QwruahJwiWd
         842SnfFO19Jw2BOhA9bg4vGdW9vIJeflAfgw7FU+aipbmiPtqP7xcLIJ9m966g/eUuCm
         I1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX1g9EuDGrvMQlaZqdA5GeJ0YO9OOEK8reoFl73CT61vQTlClhp797NZgMkd2oDbQid2fbvEOyJ+olfR4uJKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaQmOpAAb/SlBhseEfOwAoghJ8fr1cRzTOKpRjNG5cqK5O+eH
	5+F9iFhQnoPuVe1aXWpLTFsdmBRQUJdse1/3SkswfJWObsk2h7GeB6cu0YVzWw==
X-Gm-Gg: ASbGncsqxFc7nU/uXyQU8c+jfjC2r0NwFcd1wAo7Uyf3A/AjAquMb2sfMmNmYaBWI4N
	5uJKTeXUbmUElIFaLuEG+CP59KZf/w0YO3/VEJTL5FqGz6eskgWPxKKYHgO6uDw38Rbaq091KYp
	x2zAyflqOmurFRuYIvSJluO/lWivOZEoooAub7lc9E86S6qMAZeA2XhVBSoAJDT8n8DG9bJWehm
	etdHG1905A1L76ieERIbtuhMNX4Zqz9rvhtBsE/JUDl21fIm5FsXhumIx/qAtz243NMGsAsHhk+
	Kby8W9uC8Vr+M6xOeKlAJLSC2lZIWNYKCxmGtcJ1aKDg/ekV+m/XGrzJO2H+6qMmuTa10JZdyqh
	RQwgvEtIVYEmdiGcnTxnNYYtdpFjt
X-Google-Smtp-Source: AGHT+IHQV5jTm3G8dUSnLEyrinwJzwWTM8kIz3XBsskalpm0oH2+gy5ITijQxcfI7b49RgD5R1kKZQ==
X-Received: by 2002:a05:600c:3b0c:b0:45b:8330:bd03 with SMTP id 5b1f17b1804b1-45b8549c45emr1040355e9.0.1756504002931;
        Fri, 29 Aug 2025 14:46:42 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d141esm56450275e9.2.2025.08.29.14.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:46:41 -0700 (PDT)
Message-ID: <c59ed20f-8af9-4712-b9f5-8509b5665420@gmail.com>
Date: Sat, 30 Aug 2025 00:46:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v3 00/11] wifi: rtw89: Add support for RTL8852CU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
 <a81f6725b183401d8973bc648c3ecbc2@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <a81f6725b183401d8973bc648c3ecbc2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 09:23, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add support for RTL8852CU. It works well but sometimes it loses the
>> connection:
>>
>> Jul 04 16:05:56 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>> Jul 14 13:45:26 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>> Jul 15 17:51:28 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>> Jul 18 14:43:30 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>> Jul 24 14:58:07 ideapad2 kernel: wlp3s0f3u4: Connection to AP ... lost
>>
>> When that happens it reconnects immediately.
> 
> Internal experts told me they need more data to analyze the problem, I'll
> share you a debug patch later. Before that, please read 4 bytes of 0xF0 register
> via debugfs. i.e. 'echo 0xF0 4 > read_reg; cat read_reg'.
> 
> Another thing is would you like me merge this patchset before the problem
> get resolved? If so, end users might report problems frequently. Maybe, we
> can just merge most patches, but not actually enable RTL8852CU by the last
> patch. Please let me know what you think.
> 

Personally, I don't mind users reporting problems. But leaving the last
patch for later is fine too.


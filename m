Return-Path: <linux-wireless+bounces-23720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821AACE2C2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2446C3A544C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FA1EDA12;
	Wed,  4 Jun 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d+1lVIUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DB1C84D6
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056779; cv=none; b=WR8MLRSo0Fw4FBgoybF+Zr2wA3M9e46L2/ld1g4QkzLaiJT9sCObT7JwzDAfmVow4MNj7VV8QILTlgqwWWbR0w8z50qn8m9xpRwQAEJDKeCDgDeHV75pF7cX4Wyd7RwUj1a9lPZNZL6F7rRJPyBjpONRnk6mXBwoNbET9msq78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056779; c=relaxed/simple;
	bh=PRGdbARxfQzfSEDkl+PRXI6qG+AN1CcFGLsAJiGGrYw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WH+LZlI4UNaeRpSsi3e2AhyQCBZ0VvqrVemaNXNHgu+aWnU9PNy1UVzAZWj+hJxvGnR2oZLMJfHsMLdQq1a8+qZW4B4PotLxjbrT80Fw86nEQ7Xskb52Tzl7st558XdRaYE4TZAJ6Ot0wuNEcLQP6QMLp4sZTjxuyMGD7SfiLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d+1lVIUy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so113592b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749056777; x=1749661577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbEnrPzCI5WejU+0SdRvZf2ZzqsgozVyn56DobY48/8=;
        b=d+1lVIUym/+2A7jgX7kl8n1Eaz/c4QG8lPocM7B9EqzGTqxMBBT7fDsxYf8dB1aGZW
         kQaRjNJPpVFe8NcKCw+yuCOw0NmB/1+dXa0Xf/6xklkwDA/IiELGdFNo0WSh4XdWHeQv
         qbNHVBhZsV2CDox4K7Xxkk4+K8rIu/8WNwUgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056777; x=1749661577;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbEnrPzCI5WejU+0SdRvZf2ZzqsgozVyn56DobY48/8=;
        b=uGUPa6SZvsSNmJeRObWercaoYGFQECmcgmhxSJy5trV6kUlmMJWdXOCuDDoj1/MXG5
         R/mPbkNEQ6a/hblnZE3F0v88MM+6VWnJJBVgVQnK6LNKW9f2VdIlCjFd5j8ZwSLrW13s
         PGd/DMDYbkFq61bW5Tu6gHAEsl81huNOHLfYeo8J7T0xNbhG/avd4Dq3tep3GsjDRbv4
         bWnvygWehiCn+vFdmZJTkl7MkOcfLbh3+aqc5AM+h8yyGDnM5DnpY54MkMfxLDsYOLJ8
         L8NnXqSfgxwgAwLelr5s3T6KQLioO5KzgcK22MB9QAP4HY+B49/T1tK7k3IncFLBRAz3
         kKKw==
X-Gm-Message-State: AOJu0YwnlfnpDT1IsMp4jLUuHtJtPWQJJQSQ6cmjYZFh667nC6hfv/9O
	UC/xMbq5+IVCUpmgLIUK/mO+E0q6q1mEreZwkzaZ0t496TCE2LnfQLVVJ1IBILN/dA==
X-Gm-Gg: ASbGnctNpP+5ouYzUeraAIw+xfpXpsbVzZLDpDToP8u0TQZJrrJVoveMP+9j/kdTbzE
	5KGFZLkrsHj5kUiuvTQx9gowgSFCu1B73MTnUcIClSstfeJpKridePzzoIIFnH3MpD/inip+3x7
	GirggYMN0ndd667g0NujOgEvhBJMtYdBHESUgQb6uWSPAdlqFl0f5PSUlFAvtUnjM80emgcqp87
	mi0iMu1OTdN9pchcdITHxjQ2YtBL/d6lMPuW0oachLXZXxAGep+VZAOU6ROmKWbGUDw9Y6WDZe+
	jK7J8Y+Tdg+EP5bag2yQw7SCJO4qJnbOe+Hrghw5CQe4I+EDaRT0DRqXTcY59H0/mGNP+q2TnGU
	Ng5bcGXVyJpvjOD8giKeHDmE=
X-Google-Smtp-Source: AGHT+IEguPa4VugXAsNDBmdovReStS2oaZ1pYZT0PiLzM5fKveXPrubNL7gM+t9JY8D8yzDsbId3sw==
X-Received: by 2002:a05:6a00:2ea5:b0:742:aed4:3e1 with SMTP id d2e1a72fcca58-74818365934mr342803b3a.2.1749056777276;
        Wed, 04 Jun 2025 10:06:17 -0700 (PDT)
Received: from [10.229.40.11] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd41d7sm11368080b3a.123.2025.06.04.10.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 10:06:16 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Wed, 04 Jun 2025 19:06:13 +0200
Message-ID: <1973be85b88.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <966fffd8-1ff4-4a29-a0a7-fd081a12dd45@oss.qualcomm.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-4-arend.vanspriel@broadcom.com>
 <966fffd8-1ff4-4a29-a0a7-fd081a12dd45@oss.qualcomm.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [RFC 3/4] wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 4, 2025 4:24:43 PM Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> On 6/4/2025 1:55 AM, Arend van Spriel wrote:
>> * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
>> - * which indicates which BSS parameters can be modified.
>> + * which indicates which BSS parameters can be modified. The attribute can
>> + * also be used as flag attribute by user-space in %NL80211_CMD_SET_BSS to
>> + * indicate that it wants strict checking on the BSS parameters to be
>> + * modified.
>
> again yuck that this attribute id is a nest in one usage but a flag in another
> usage :(

Here one usage is from userspace to kernel and the other from kernel to 
userspace so with proper API documentation those two can coexist with 
special handling or policy.

Regards,
Arend




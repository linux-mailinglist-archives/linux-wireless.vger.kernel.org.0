Return-Path: <linux-wireless+bounces-19462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06FFA456EC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BDD3A903C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817DA1898FB;
	Wed, 26 Feb 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhG99Fhz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBD18DB09
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556015; cv=none; b=Rr8+Ctif17PdEuWFaS2FGGkRV9m04eaBCVS+MMo/3qZU7VcTUx5HlIcC7Wl7JrbAkPc4LhEjzmtjSSB3mXrviq7KoOIR0dzkaEdydKklHJDiJDq6MRmHKZ21uX4FJZLw+k6+gyXZTo5t4Q4XDEaOLg7HrSnBpZFsx+lPCVcx/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556015; c=relaxed/simple;
	bh=m76MUj7AHyC7RQnZfOYs8NHa5tpwMbh8lZ7ZZTs5dJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHf7aZtDY/iwQ8ulXjM0IDjnVaUXTEpCqmOZVTu9jO5H/3WU+6i/55Z44ruNUccfJnTIi8mO7hg3J5r3M7QTa3v7Z4yr2hzPbx/sMLb5FQPU22Wfaw8P8B4F84QEzzqswlBMqoKARG3gek9XCzlVVTOjeGRJxZVVJMySAT5G0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhG99Fhz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so4607612f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 23:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740556011; x=1741160811; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRvVQwWhE3RVeyvBkj6Yo+xtUoKhFPz7MreHypfvjQ8=;
        b=LhG99Fhzm9rStxBswbqL9QboigY3jwU1QOx52N/cEwG33It+2c3ca6jVQayERccy9Q
         WHfpYD/09vA/FRZqSKbJbflm0ljcz/hHGzExDUYu+rWHvShYiVdcVKncHOfkfllu+3qc
         UnZ4qMI+e//bQVm0Dg3BM/6trllR0LhrLAOjVMXWhBgUg1b4O02dZq5GZ/nwBaSDSrl8
         tlSv9hL9n7o73MPML/9rfbMVfeoCt+0+TlGm0Dn1igHcmtTdwc+rzMLIzQs5GMtsEqEx
         RpZFGk8OzBLePZDHjHMQIg7UgBxH1vPNoLrVN33SFDuZpPmaLQrKJyEd7fXW4YWdEv6z
         Awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740556011; x=1741160811;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRvVQwWhE3RVeyvBkj6Yo+xtUoKhFPz7MreHypfvjQ8=;
        b=FwQzdSO0tScztNSSwKN1tE8fOBxbDeX/D7Gn4hN6/KpHSC8zKOJyQiOWPM6thABAhE
         5OVbz/UBzCYH+vlKjshnbHRZalXppc2ecfXlOmTR24F1So1w9psWTpZojLDrLR1oMXLZ
         RHa0qCggda+0HLjHukFUZL+JyTzCzHTgQyBIaKMnaCQ6arIeaLoA+QTF4pCQUlkrp1X3
         13UfumFrBTWNqjtC0BCkZwmalrp/XlSsMlsokGdLlvXUNee37nHUpXUTYcpBzHqcX/6t
         XDma0njthX5B+adAVUxMSMSIekeg7aj95J6KWk4kNpBxm+BT45vFhGTiyhc2DCRoTUX6
         Q5uQ==
X-Gm-Message-State: AOJu0YzlvuLE39uRNhlWyYzsn99UjWs3YDWhL1zHrdsOVfqtOjjkz+PJ
	6zkPopJLb9BKZjGbFoIK7Uu11+EQ96pBzs07yf4Ho1KbjnwFCIsBeVTo
X-Gm-Gg: ASbGncsrNfn3Jt/DiXC79P5bub29hOdpMWiri6rJUJ8MMoPwBMRx5VlJPpe/WnF7buJ
	GkXvkLjszmzZ41GSlx0bMhkleIYO+cp5d3CaoyVP6jSnlsnQaE66jqkU36/WFWkrE+6OVw4y6FW
	lGheykx0MLGH43PZ9r0WkuJKK+nMn5j09IShuvP1YgTIYYhjlsMfut6JMKgdghFgndb5vjCBmO0
	D96qyUdLbH48SluKEr2Ez89SqcICGnhOMl7yO7hvvab0CWOcuB435vdgjHBTrJ1JJ/Nr1AbVeRr
	pD3+B+4h5nrR3LwIcy4SvqKo+2BugHk9ooHNSlyC07kYeaLfRCXQh4UDuhupr3bHqDG6D3r+FxK
	ATr0tUdKuBps3
X-Google-Smtp-Source: AGHT+IGTyaetv25p95cdeaw6HFL5WFafxLFjudHA4bRs5ToLFc+FrvV2+hkhLObGrAD+nJHy6Ks7Lw==
X-Received: by 2002:a05:6000:4021:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-38f70799a67mr18789352f8f.14.1740556010905;
        Tue, 25 Feb 2025 23:46:50 -0800 (PST)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net. [86.18.22.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcca2sm4640859f8f.96.2025.02.25.23.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2025 23:46:50 -0800 (PST)
From: <rmandrad@gmail.com>
To: <linux-wireless@vger.kernel.org>
Cc: <wireless-regdb@lists.infradead.org>
Subject: wireless-regdb: Allow 6ghz in the US
Date: Wed, 26 Feb 2025 07:46:50 -0000
Message-ID: <000201db8822$98f28da0$cad7a8e0$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AduIInOm5OAeUzeORjOSV3pwYv+NMA==
Content-Language: en-gb

Allow 6ghz in the US

https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-u
se-of-the-6-ghz-band allows the use of 6ghz in the US namely section
59 https://www.federalregister.gov/d/2020-11236/p-66 with absolute radiated
power of 30 dBm for the 320 megahertz channel

based on this remove NO-IR flag and allow 30 dBm max power

Signed-off-by: Rudy Andram <rmandrad@gmail.com>

diff --git a/db.txt b/db.txt
index 803f1bc..bc2b4fe 100644
--- a/db.txt
+++ b/db.txt
@@ -1953,7 +1953,8 @@ country US: DFS-FCC
 	(5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
 	# 6g band
 	#
https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-u
se-of-the-6ghz-band
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 6425 @ 320), (30), NO-OUTDOOR
+	(6525 - 6875 @ 320), (30), NO-OUTDOOR
 	# 60g band
 	# reference: section IV-D
https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
 	# channels 1-6 EIRP=40dBm(43dBm peak)




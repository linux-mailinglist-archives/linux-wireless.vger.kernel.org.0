Return-Path: <linux-wireless+bounces-9460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4F9136D0
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2024 01:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F3F1F225E0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 23:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701826AF0;
	Sat, 22 Jun 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE2P8LrF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171D4436
	for <linux-wireless@vger.kernel.org>; Sat, 22 Jun 2024 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719097322; cv=none; b=aJXhjthtQv168ng50vUUvarHinccRpOBN00x5d4EfrxNE+UJ3zQjEGDKKMw+2q1tPHsIIc8AQwO+RNqbAyQikk6WOMCM13tcNodmB9MdwZjGCQ+iMDGukxMVDHgNl5sObXD3p+ARxp+b0HmmP5WcLfCvlYnw1RcVNS6BKPH9rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719097322; c=relaxed/simple;
	bh=9kJ5rlEJyHdBfM7JrRI2/Cy7XpCDn+ASK1oDohW5/Oo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KVQXBVLrYLkhiUPyW0dkckuD4M9F74P5esGGPGIW3sUz4Qd+T67J+QEXZ/qeuJvbjPrWjLSJIJOaPvhI5asYmNAGX3HwgjiMVVsL8IfHVrD+hlZvfFDO8THC1IEyNNXET/hRcSkqB365GfWvLTWad4H9BvdEXl8jpJpgliGeiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE2P8LrF; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f8ef63714cso1891640a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jun 2024 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719097319; x=1719702119; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrXv5rk7KvvthtKDIrjiuLpaQzfTSD/KaR4o7EmPBLQ=;
        b=aE2P8LrFAykY/4NR0Ldff99/0iICIXHAh4ZmNXd1nZqtAwtEX3e1g2bedv3RHf2UmU
         JE/JCdwlvq1uNmP//eD1QGJjjo5ItG1SwjPylyytMzl6ii8KLUOpJtTI+YXqqmuPGBSK
         Jti1T74pEpUW4Yt554luxD5shh1U3yq+RuKhAnyBsTfCCSewlgvBydVhkr8P78S7DR9m
         KwtLrI9jIJEgqi5dEljF213Tlp2aJTKtP2J9zTh6OHS/+fP7Uam56eLrpq6Kyqmt/W8w
         8rL0wKfrS+2zDPX/PaQfbmQ+dTZTtaXe8iQSR1cly1j4X0hEToukpzNqVtvSj0WFA5W0
         3RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719097319; x=1719702119;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrXv5rk7KvvthtKDIrjiuLpaQzfTSD/KaR4o7EmPBLQ=;
        b=W65lxItYLW49sobDlHRkcvxY6ODZwMZ9kqN7CjeY6J5H3cokzLdZaSyGlSs6V9ieW4
         5BmHHEv9iZhOw6FosNPp1JVbphEDBQe7WAUHEkF4U5peyh8gqL43X6IMreWLbhz9W+za
         u+Hv0DOeTCEhZYMy22eIskiP7Q58xsU7I+HWXyyFMklBsYzrEWwxqft4fST54Qc5E/Cz
         kaOA9A/3ErHRdw0cXA1clsZlOcCC7nJhgItkvnY/UVi9/6s1ussKU+xL+lHNt3rlGSPg
         v2VSeS6BTSCiDWtE2jrbsv80JQrnpZS6NriUPESODeiqfDEqPi9ssVh0dswmfzVc+Rfp
         0yGA==
X-Gm-Message-State: AOJu0Yw2SHdpgy7glRow7xyeSERMg6z8jeTwwDU05RsTX6f9Ri/hDEps
	qYKchiwRxrtJOUryWkfUNaODQptqUqkrxqzEIPQM9ghxU8+HidWuCxs9Dg==
X-Google-Smtp-Source: AGHT+IHncgUef5eUTY+pmuPwJJXP2gBvFXsSMxXZcklgeTWW2Y7ONC/NP4m9IDJbfWLuJTxHTgjOtA==
X-Received: by 2002:a05:6830:ec8:b0:6f9:8a29:8e8c with SMTP id 46e09a7af769-700b1282972mr1195819a34.23.1719097319204;
        Sat, 22 Jun 2024 16:01:59 -0700 (PDT)
Received: from [192.168.1.144] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc033sm786341eaf.24.2024.06.22.16.01.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 16:01:58 -0700 (PDT)
Sender: Denise Finger <finger998@gmail.com>
Message-ID: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
Date: Sat, 22 Jun 2024 18:01:23 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Denise Finger <Dwanderer@lwfinger.net>
Subject: Larry Finger
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is to notify you that Larry Finger, one of your developers, passed 
away on June 21st.


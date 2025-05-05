Return-Path: <linux-wireless+bounces-22456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E76AA9657
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD193B9B40
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89226A0D6;
	Mon,  5 May 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrPsw+rA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472326A092
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456440; cv=none; b=BctycYjhR6urmhSMKZKqOPdrXHcNlpuobZSwqCK4x19P+a82povog5kov858ypwpbVYdjwCUXhs7co8S7sTvHon4horLBh1UJV/520rIzWc1dS9USNuLKcsO3/mIO6pvQvrsxE5LzcfwCmUysPS9BtYPtuz4kwfrSs0pCgzZ5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456440; c=relaxed/simple;
	bh=EC/DMhWZGPB+9sR2jBYt5wRMzmAr+C9tw7p5E40r0Y8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WipPzEp+XacYvII2BsaV+gP8wGJ2uI4ESOmIHm/MlqinlB+P0Fi+VpgEHnmzpGIp74vNJKKxQ2HWQGs1reLAW75qiYJN8CECkxljzvA+f3hv1EvHmEIGRHu6MBfGUaL9BkvYDwucihGPvq0KCS6/jGR3kWePjA9xGC2NTJ9lTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrPsw+rA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac289147833so844769166b.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746456436; x=1747061236; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGdVQwnXjxTr0vf3eZ+1/oB7AsF8CGbZBKMThK4AHZA=;
        b=FrPsw+rAcWpqUWBH5kio26RsSGla9PDurqo+WgpV+3q/naeQY+EHEnymWEU2PQQkFP
         E/Prleqj3KSGnumeDRCdAIlzVJN1uv2a19cVmdx16gKcoCF9U6TwaGgOoZYeLnfEZJaX
         odQBwJl6xZJCRtTG43MHK1j9lWfSbP6F7QHmiFMWr7OhmAnOHw7ygklOOAIxBH6Mv/2q
         LYESln6LjonwsEMHh49P0rfwm8Qr3CO83RsDuFdffbkSGPjJLVinRBhRV/R/8dkJefX1
         +9AUK1FY0iyqNYrDuZG2L68Jzv2Qx5gywKXR/WVQPFSwREuApppsjeeC6ROAcEkPbNnZ
         BYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746456436; x=1747061236;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YGdVQwnXjxTr0vf3eZ+1/oB7AsF8CGbZBKMThK4AHZA=;
        b=dyS8/UKhgvB9+TafaFbXmPFgRZVIoUMHhxgDMo8MI+hse0oqIJtaMFwpLkU6vzhj0a
         PMVCZtbJfXSyWYlijG2QR840bewXFgzNLylZf0Dexxg4lffuwV4ACZL72q/wBcMtTMyx
         zQxXewyGT0rjw1vXzB42rebB4sIsC231G6gq11VP0+QliTS+AIgPSpGKvUx2FoMo1OtT
         YI/sy6vTww8Ct8I+GSGqUFUFkjQDSlqRWU3HHawgv9YWRt+sTvIx+pGxl3qm7EvnUnsR
         Cy7nhW+UgxxNcYl8VOBEajAXmbKmdgViSfmI6k8f3rL8Gvqr20PhKNv3C+ACxhkiBYnT
         oQ0A==
X-Gm-Message-State: AOJu0YwJ7visAcD0tmjnYZXicFpNuS0MtRJNyESe0m92ASum7mHvkLxX
	ROqy6c5jwOt0+F18yMYVkKJhJ08s5+NJBRH+T1qTKa8M5L8F4fBCJc57+A==
X-Gm-Gg: ASbGnctP3/PNiqubTlu5BZ+FGXlSN5tDgYLy61bO4UWEUXRAOhPNMiM4LQWRAfFLILv
	pkWsSXDup3LoR91A6X+gWMdxtv8UK0PZ1C61HeJnKlEYzra1HsJwtLCkM2cC4/yY1jZC9dLtxoQ
	fK5bcDd1UwAgCKiOKpnY8ukG52k097JI8qrtC/nJ8mSpORKjXHM/lj6YwumNZiBtDfRZW626M7K
	CPiH35j+bolG12SrnJtWDFV8UMQJ4tlPIb0XDECJsuRIQ3YByyxTeU9T2HeEB/ve2hj4IhFjgFa
	PPcjA+UdBUb48miqHvusxGoT72VEmZQzlbWeDGLwNkJUjDIzuw==
X-Google-Smtp-Source: AGHT+IEnt+5482F4888fS8aTKlD2wwVrzK2E56A/XnrNs7zX8i6Cka78Ztf6bc4WCxYr2w3y+RVyfA==
X-Received: by 2002:a17:907:948e:b0:acb:baff:fd5f with SMTP id a640c23a62f3a-ad1a49e6d72mr633587566b.35.1746456435781;
        Mon, 05 May 2025 07:47:15 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189509661sm508250766b.149.2025.05.05.07.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 07:47:15 -0700 (PDT)
Message-ID: <ccaf49b6-ff41-4917-90f1-f53cadaaa0da@gmail.com>
Date: Mon, 5 May 2025 17:47:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtw89: Null pointer dereference in rtw89_pci_setup_mapping()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

People trying to run Openwrt in Qemu ran into this situation where 
rtwpci->mmap is used before it's initialised:

rtw89_pci_probe()
  rtw89_pci_setup_resource()
    rtw89_pci_setup_mapping()
      rtw89_pci_cfg_dac()
        rtw89_pci_config_byte_set()
          rtw89_pci_read_config_byte()
            rtw89_dbi_read8()
              rtw89_write16()
                rtw89_pci_ops_write16()
                  writew(data, rtwpci->mmap + addr);

Their wifi card is RTL8852BE.

It looks like the problem was introduced in kernel 6.11 by commit
1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address").

This is not my bug, I'm just forwarding it from
https://github.com/openwrt/openwrt/issues/17025.


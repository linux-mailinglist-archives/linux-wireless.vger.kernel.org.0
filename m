Return-Path: <linux-wireless+bounces-8065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7A8CF2AC
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 08:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3756E1F2124F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D841C27;
	Sun, 26 May 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sqVx3Tn9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF71849;
	Sun, 26 May 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716705381; cv=none; b=Cs3D7LNIsjHhQ79MhEWVRC65TWcSWxm64gY1LIGkDy7lmUdACT76dP05q6nZTqKJx6+2n65v8tLzEskmKDQnqLML0kw9ii0C5XuuSEar3z5pZZMRd8n9BTBCxx7jEcT4lTFJHrDC/hqDvSvD46cNF1HSGc20lsTtkePEBodkoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716705381; c=relaxed/simple;
	bh=dSe/spixs5ApqjgYm/X4+SVSriMdGKzobyY1DlqnnEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BxbpDhm0J/dtQjlhDiR1KyeyiydopTG6Ctux+zi+9R5O7AILbPkonnRzoOS1jLQjkUb+AF3oHpHuutI4pvffZTI0KdGgh28EmJ58JuWdfkwgFWQ97EDX+05Tjwkwf2DZMkZBCB9Yi0dLwZP50bRm5XIDXetfeIRzr+jFf06Hl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sqVx3Tn9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44Q6Zllo080701;
	Sun, 26 May 2024 01:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716705347;
	bh=6gX7cZSZkx3L27ZPyp9s5Fptuzr9oyyi4A1VrdhCEMM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sqVx3Tn9SMYqGNRFi7GQg453kyw5grWzB3wlLIdrYNaZl1gi1/ljZAKCFbWdQfkxV
	 gJp8DlJRA8goTS+vEQmyytPACJCZOSPQUbmuB60qdw4wtBUQzThJesit+hK5CpbTqb
	 heD8Ajs45c2rYasz3D0jmI9rD4Gqz0V3bVy7lgYU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44Q6Zl3l105952
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 May 2024 01:35:47 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 26
 May 2024 01:35:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 26 May 2024 01:35:46 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44Q6ZiMn036976;
	Sun, 26 May 2024 01:35:44 -0500
Message-ID: <96d5ccb5-660b-4f40-82a3-83495da4f595@ti.com>
Date: Sun, 26 May 2024 09:35:43 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] Add ti,cc33xx.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-18-michael.nemanov@ti.com>
 <1686c1e6-94c6-45c0-adc5-c05d49614d30@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <1686c1e6-94c6-45c0-adc5-c05d49614d30@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/22/2024 12:35 PM, Krzysztof Kozlowski wrote:
> Missing commit msg.
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.

I'm working on mainline but was not using scripts/get_maintainers.pl 
correctly. Will fix the address list for v2 along with proper names for 
all patches.

Michael.



Return-Path: <linux-wireless+bounces-11823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4C95C38B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 05:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E677528384B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 03:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E02D058;
	Fri, 23 Aug 2024 03:04:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88C29CEA;
	Fri, 23 Aug 2024 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382285; cv=none; b=Cqm1R7Hod7pcfzf60t569tJ7XV0HNICdogAB1d5hkHwKXFxoq7J2UJmgPTg5aYcEGmJbUyPi09eT4Te2IVEUWkyXemHgt7TqOGDETxpw8paGab0iat7M9xLRxAigl1YXW7cy0gS1O201haiUVLlBCntsnNCywVcAYfEM8BOMr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382285; c=relaxed/simple;
	bh=f4e1VhDyQTp/RzUqC79vd3LL+HdDwEnfeblf6og8ELw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT3Fc5CvwxCxumY+TbeURryj/rGoUVMgQzi9krC2bPYn9SxZJ675JjF2BXinBqh2Jlrq//CiHNunJocMpi6LoSrJD4UHBzYeesjy0+fOQKC0romkJZEaQ1ur0lTeCAER4jPdn6i+ZPvzuzP+NvacBq0s6kV8C1clVKQXxces2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowADn0ME3_Mdm8RV8CQ--.11516S2;
	Fri, 23 Aug 2024 11:04:36 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dan.carpenter@linaro.org
Cc: benjamin.berg@intel.com,
	daniel.gabay@intel.com,
	gregory.greenman@intel.com,
	johannes.berg@intel.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	make24@iscas.ac.cn,
	miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in iwl_mvm_alloc_sta_after_restart()
Date: Fri, 23 Aug 2024 11:04:23 +0800
Message-Id: <20240823030423.1781977-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qwCowADn0ME3_Mdm8RV8CQ--.11516S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1xKr1UJw17Ary7ZF1xGrg_yoW8WFWDpF
	Wakr1YyrWqqF1xJrn2kw4jva4Fkrs5J3W5WFn5Gr9xJr4agFW7XrW3KrWq9Fy7uryxCaya
	yrWftF9Yka4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Dan Carpenter<dan.carpenter@linaro.org> wrote:=0D
> The Subject says RESEND but doesn't explain why you are resending.=0D
> You probably meant v2, but again it needs an explanation.=0D
> =0D
> On Fri, Aug 02, 2024 at 12:27:40PM +0800, Ma Ke wrote:=0D
> > This error path should return -EINVAL instead of success.=0D
> =0D
> Why do you feel that way?  Have you tested it?  What is the user visible=
=0D
> effect of this bug?=0D
> =0D
> I slightly feel hypocritical because I have send lots of commit messages=
=0D
> with exactly this commit message.  The difference is that I only send=0D
> really easy patches where it's obvious what the intent was.  A normal=0D
> kernel developer wouldn't need to leave their email client or view any=0D
> outside information to see that my patch is correct.  If a patch is not=0D
> dead easy, I normally just report it.  (Sometimes I report dead easy=0D
> bugs as well because I am lazy and maybe it's the end of my work day=0D
> or whatever).=0D
> =0D
> This patch on the other hand is more subtle and it's not clear why the=0D
> continue statements changed into returns.=0D
> =0D
> regards,=0D
> dan carpenter=0D
Thank you for your response to the vulnerability I submitted. Yes, we =0D
believe there is a similar issue. As described in [1], it gets pointers =0D
which are handled under the protection mechanism. If the path is error, it =
=0D
should return -EINVAL directly instead of success. The discovery of this =0D
problem was confirmed through manual review of the code and compilation =0D
testing. And by the way, I resent the patch because I hadn=E2=80=99t receiv=
ed a =0D
reply for a long time, so I resent it.=0D
=0D
[1] https://lore.kernel.org/all/MW5PR11MB58102E1897D7437CD8E1DF27A3DDA@MW5P=
R11MB5810.namprd11.prod.outlook.com/=0D
=0D
--=0D
Regards,=0D
=0D
Ma Ke=



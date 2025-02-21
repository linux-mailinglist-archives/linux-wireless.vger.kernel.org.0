Return-Path: <linux-wireless+bounces-19294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306EA3FD38
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A2F865438
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5C24CED3;
	Fri, 21 Feb 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="ojU5IF6b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299224CECF
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157866; cv=none; b=mTcWuIxiUZDbHC2tRmgDUHDx6EkX0i7WVhNDMQKscvPzJ1PxagYuwqW70UeO/bUTxWf8V27WC88bHgGpwI3ahr2Bap6l4L03MFzxEH5Vh5sV3nQZlzKt5HdRSUXcAIQjpEmLoinRus9A0CDgeBOHUeN08ahgpGyPtx9rtNNlSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157866; c=relaxed/simple;
	bh=noEQeWdAqkuac4lCmOa5ze7/pbs7MO3ZvOHQlFXxBvU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JKdBni8FfFyHTB/UKPdnMQ+AaPJxYrv/l0BvcSSXVzzEJVcyyoXz9RCTeGPg5NL0tjGJFjKVwVoI+hDlwDtwcmk26Sne30+GVdWZ5x1lMAD41m6TIuOHW9bUNNt2aikxsuJWtwBal/DzmzEJNJoxCmZGZQcGLCmN5WdR9tMcBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=ojU5IF6b; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740157862; x=1740762662; i=aros@gmx.com;
	bh=noEQeWdAqkuac4lCmOa5ze7/pbs7MO3ZvOHQlFXxBvU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ojU5IF6bRwOSNQuglEicj4AXrfuYNSicmlrBdJ+n9X4ynP6K5vB5k4xqiheV9r5y
	 U/Qsdkpm64dF8OpHdN8okmOgmif+7SQUFyltQv9gLfVehYVdIBxk16Rt0FGHi5UGr
	 J68pD50pMXE9/2KNQLO8eu9Ez5DRLhMD0/Rmp9YKomMmO7xCdJgHRPjmiO8FDJh7V
	 dAl7Bca0kdJMIoXiIgieJGyfqrb1cv96E5Ai7YOUnOM+ElfrrE9W2QgGi9WPBWsYW
	 sEV5ITD443N8fCDpd7Jc7hqse8wF9Iw4PlMBMV3U5TQOxcJhiGMfYSmwGcu7czTGY
	 vLYu/rZoCt6qNnrnrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.14.19.2] ([98.159.234.97]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC34h-1tbsQy2mQn-00FT6n for
 <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:11:01 +0100
Message-ID: <ea0541a6-9d4f-4d1c-8b4b-4bb29eb84639@gmx.com>
Date: Fri, 21 Feb 2025 17:10:59 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-wireless@vger.kernel.org
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: /proc/net/wireless has gone missing in 6.13
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dZXq9MOGZZw7zeFjCwPRt6Z2iZo2swv7KbPL04wdOPbpOF6PwHg
 EEamKKb92MTFDpkeQxVtTad8oO80qAiHYZoLO+V1B6ewUc/1+r3up+8C7LCTKqvpmz7N18m
 VtW6NzMxNz7RqTgNOJB4mTuhqqm6MbO7pYY8aCcTqbV4utN2+FMbvDtJfniSqLdqvNYwAbR
 7edPBHNqpttJ0VI6Tsy6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mYQno0heI3U=;dCwuHYsnRrTPr6JCI2+4aPNbgVJ
 e5XS6UzHB3NsmCO5aDS65odl3hTFsUrJ2omxWMOsdB5EqbApKtchxn4bmQuWhC7YTYHhriNTW
 4wRR7vAn4ebLDOU2UCA7+ERZrxMmM/vsv0igeSz5b+yn0EZeIgSch3ZFt4qus9YHHHzFxVfKc
 MdplTW18/7YCrw7miBB2GpW7InVietV8ps6NFKKWW70NQq+55nbv+c2KwVk2Tobe5x2nzfHqA
 HWmj6g+D/5kvJ1fDS2RzokfgKL1fO/lCbrUyzeiATsR1v8a/EpQxX3SLeutqkZsMhd+0z0wXo
 o0DuBs8Oz/pbj28bKnIk8atRvnMw9hkYSuPePZbs9nAtrB0JkSSE9Jnbl8UE7zwgIXM/kQkdD
 rImwWqOwpm2ZVHjKQZ4QjJSkkdxHCVdYD6NVf62dHGdUIuOfT6739RZ0ogJk91xXv3XovVzIA
 d1zaNpp3GHQpSyi0BCfcOjKuS+9zNNxhQPdoh81CXR53/tu5GpO8TWuL3X4WZLxu0CBY4MLw3
 LEg0acikSiA+0A8YZV1I7D+YVs9MFsfw/J/STSLUKBL9lu+RPnlezd96fGQ3b8/ro7/ZN6peK
 YCzPk5g9M61WiVOGpT7bKOwlBcZsKzCxcnuI4+S16IDOp6dydvLKOCg3ALHbZPxC53ox0dwjX
 9b6MK30WZ1F18jqFQLXEqdw4d4N6CtFEfHM+uJzx46kP9jUb+p5G9/j0nEfC6WYvM3G31cutb
 I+0xYsTUHOIqfB4jkr6h43o4Qc4h8qAJrLeAJ8Yzy9/JvJgCENzja1Dze4W9tT22G7W5SNZeN
 iUjEkYq3uiZCy2YT433PC2zVZqoV35riFsx03pjKLsqSr+XQ3mj20vIJ+netQMhxPpsx3nd+9
 8SqcAp16fJPuvdptpsUnNSjEiNhgcnSkEWVXVC/vNzCsYj69HKGscg9Z9PW41szJGVO6sJuKs
 Y/jvebmflujXeF9qFYTtbocQHqFz1i6XUcaMuKXQMSbWuHlCmueamJQnFL/9UBJ7mcoLzDAGy
 kzngJXl5kqPa+s2ziDAW9zr9BtHN0Zf1Z3ssg5pQsXnWa08N42WJrKkWDaiyYhXPav9mQNypW
 YqcckWeU0qNDj0OZc7CzXn3Mxo+d9DZr6T1nUZ04ykgqK3an1tt0JNCO8FAX97WgGSBkmNSBG
 Cq+cl9jQXxu/zx3dALBRExGzMmfLa9fQreWCocdGy9XQ7vc06h6ZyGZn9rXNTvJLWXg2Qrrvn
 lycMxS3idzNIFZQ2qz7GFUROX+3tAeCjxVNBoPA6KhGy48GzGP3fdlLVR1X/dLrlyNFZQM4EC
 IXv+H6TniVxRYXBj3OnkdUsY0LclKvam3lIUtGyKjLcpF76F2SYjJ6Q6sDvrcIKaOV67NmmvF
 OVjLWwFfm9aFptJZ0gXkZP9/f7E7Es8m5hphp2j09GaeMg13PWrChMCHDpRdr/x05q0VR8kBn
 ev+aY+w==

Hello,

Multiple people report[1] that /proc/net/wireless has gone missing in 6.13.

Many utilities/applications depend on this file presence.

Please restore it as the kernel mustn't break userspace [interfaces].


1. https://bugzilla.redhat.com/show_bug.cgi?id=2334171


Regards,
Artem


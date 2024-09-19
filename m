Return-Path: <linux-wireless+bounces-13012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625597C735
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE161C2659A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FE19E80A;
	Thu, 19 Sep 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b="TURSKwLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C219E7DC
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738888; cv=none; b=dcLyZNf8z7xCFW/QJ5b6q6YlhvUl7Pl7X/Ek13mKW0Uz8Av0zqSENGuSrkooGxgdfag9/jC+T+gGxNu/6jFognWWkgm9rNZV9fV0ufshO8TpRm65ZQI7F9oNwN23QwlDq2o9XkS6auHgDQzH32cuklccPtm9MV4zE2ZytWJliE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738888; c=relaxed/simple;
	bh=v/2HZX1efXD8cwKWFVrItwbKn7vycnBVNMJvC1jX1yU=;
	h=Date:MIME-Version:Subject:From:To:References:In-Reply-To:
	 Content-Type:Message-ID; b=UmiYxAonAqdojFKGIwDW7BNtX/XKeR0ILi+JR63/r+bDi1x/JwmydE+osjcVmRrX5o0XIgJ0GfNb7FGrpu8dZuNbg5WVcuxYSb5LjlaSSYgX8Ww0Yb0jxhc7eA87OKLqNaZV2nm3GbZHuo1ibLqIqGsQA5FnCXuU/7FUJLtF/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b=TURSKwLu; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1726738869; x=1727343669; i=dknueppel@online.de;
	bh=v/2HZX1efXD8cwKWFVrItwbKn7vycnBVNMJvC1jX1yU=;
	h=X-UI-Sender-Class:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TURSKwLup/EGjwiGaLpLzY7A9mRGLl+8N1Gkn2E2p4I3JBsLUkdvPk/bbNMLTtCp
	 q8BfPAtQiwRIP9iSHiwBeg+L6p5oljo1efW0ldwUGCBiUT+WdTFs+kxwU447JXdQQ
	 /32pkHr+NkPhafYmLhx6MGxrS1hSUjAuHaX4yTkkCShPMmFXVmoTCyGsMMM7Fg7DF
	 /o64VZY1rM3/z3ecUPTU+KYJJYjYFyt6cWidHyRakCKZVH3/BnNOd5LSDy1tdBf8L
	 BkrfrQz4PxGuCGrJIRKEWrjx9ox7qdjlL1Q5jMtGSeq9QE8HUzRKrerUsEyKB5wz7
	 O+LPsGrmZAQ1mWsI/A==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from xXx ([87.122.96.46]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M60HD-1ssaR40uPj-004SsC; Thu, 19
 Sep 2024 11:41:09 +0200
Authentication-Results: kalliope-7.home.xx;
	auth=pass smtp.auth=dknueppel@home.xx smtp.mailfrom=dknueppel@home.xx
Date: Thu, 19 Sep 2024 11:41:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ath12k - HTT timeout error with NCM86
From: Dieter Knueppel <dknueppel@online.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Dieter Knueppel <dknueppel@online.de>, linux-wireless@vger.kernel.org,
 "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <14e17e9a-638b-4bfe-8a2a-99b524a20acf@home.xx>
 <1MvJjz-1s0CoP3EEz-00rhmL@mrelayeu.kundenserver.de>
 <7488ed13-82dd-4b41-97c7-5692cacfa631@quicinc.com>
 <6d3f1f33-2a9a-4b62-a0a0-02e65bd1b461@quicinc.com>
 <eb1c8576-bf2f-4ec0-8651-62e97446e940@home.xx>
Content-Language: en-US
In-Reply-To: <eb1c8576-bf2f-4ec0-8651-62e97446e940@home.xx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 6.00];
	BAYES_HAM(-3.00)[99.99%];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Action: no action
X-Rspamd-Server: kalliope-7
X-Rspamd-Queue-Id: 075EC3F90A
Message-ID: <1MI41P-1sn33411oV-00GW5c@mrelayeu.kundenserver.de>
X-Provags-ID: V03:K1:ElVhgIPr4oTnuiCdNsZ1Ecv+QfExUGDHemxagLDSs6JGfN4qojy
 +X6jcEa2cfOXi1OKqfVRM9PtmF1BWInLcsYp7o9LjfgCvTc/OWjx3Iekq52run32lIvyh1m
 Yywob2Yibo2XV4Nbpiy22N030v3U1ZdPwiHr9fKPuOkmEnYTA+zeAiu0dpuIXJmsbq07WFF
 wawaNuvtOpoYrBq1z1PlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:64cTG6D1Zso=;gMu3BytVfKcYklA2phax1sp2KXm
 Squt4NUy6GM4YURFU0QWM2RgQDeA1ffL2KZR6HVknAu8Kp1jlQN3J7xLM/KT9S42nTln+IUUf
 t54jPO5wOxSJ5v4T8CU61bdNX25Z7lJ6r1EiyhOADbJUYKeD1Tf55rrSCLslg2PcukMacGiB0
 /ik+KFk5TcLeLkIPnWVRh5BTDKhDfBVyO/uxkR5X5e92dv4gh4dbErf+CaTGunMOnSxqP4BHW
 Yl8xH1PjpC6pxZboQtgFUVshW0z93SxkfaQucWCt1Mb7nEatn4fr+FjFbyB+I014OtyYFx4LC
 LH0ic2ArAnz+HdWFt4c02t0teb1YfV6TXIWWwRaQP9fwEu8aaTylIiQF/J6UYMuZj89878eBP
 HNSakkxEOjgu3n+GLpfMvVzNgLOYmktaTBuST7U8i14RQA+Ded67ViQP4EffzHH9ylTUZH70H
 5/8ZuyQ0Rpnr2wXI7aLG2zahpp0VQqw8pvGh2l3gAlbxwl7G1xIYHAaciLsU1QsibNOZgjgWH
 J9knPgbGrENaykPALslXRmoZatYsl4GoCb8MDt6OzMF7k6V1yn9o0vAIDED08mf2p4zaVrhbN
 c3ds971LUvtsY+nOlJbMA6Ec2GbZVbzdQjJKGldaHxPa0B53Bz3XExBIiowl0eg1LqO1sPtFi
 0UaiuKHrsWYpunCyw9p5ePvjlf+GKs2wymB+2m8L6+XquDKVEpeAs5ZxhzkMs/hWhezdixw6y
 OZIjbriCbTKTQjshj1aRYk0BDiZvnmCxA==

Minor update:

I just figured out, that even the physical machine with std. Ubuntu
24.04 server (before the VM gets started and PCI device vanishes on PM)
reports: "Unknown hardware version found for WCN7850: 0xf"

Hence the earlier question, whether "MSI HERALD-BE" or "Gigabyte
GC-WIFI7" is supported, seems still to be valid.


Am 18.09.2024 um 19:54 schrieb Dieter Knueppel:
> Hi Jeff,
>
> thanks a lot for your update on ath11/ath12 related vfio support.
>
> That's actually bad news!
>
> Do you know whether vfio support vanished per accident or intention?
>
> I.e. I'm wondering on why the ath11 patch haven't made it into mainline?
>
> Assume there are no other 802.11be Chipsets supported by Linux, which
> can be used as AP within a VM?
>
> Kind regards,
>
> Dieter
>
>
> Am 18.09.2024 um 18:13 schrieb Jeff Johnson:
>> Resend since I had a typo in the ath12k e-mail list
>>
>> On 9/18/2024 9:05 AM, Jeff Johnson wrote:
>>> On 9/18/2024 7:40 AM, Dieter Knueppel wrote:
>>>> Dear developer team,
>>>>
>>>> I have to admit, the earlier post "HTT timeout error with NCM86" is m=
y
>>>> fault, sorry for causing confusion.
>>>>
>>>> Due to earlier tests with legacy cards, the PCIe slot was still force=
d
>>>> to Gen2 :-(
>>>>
>>>> Putting it back to <auto>, with "MSI HERALD-BE", similar to "Gigabyte
>>>> WC-WIFI7" i
>>>>
>>>> consistently get: "Unknown hardware version found for WCN7850: 0xf"
>>>>
>>>> Which nails down to the question whether any of these adapter is
>>>> already
>>>> supported?
>>>>
>>>> The M.2 NCM865 card as such seems to be supported.
>>>>
>>>> I'm wondering about the difference, as there seems to be no additiona=
l
>>>> logic compiled
>>>>
>>>> on one of the two PCIe boards, just bit of glue logic.
>>> For better support on ath12k driver issues please include the ath12k
>>> driver
>>> list (I've added it to this reply).
>>>
>>> In your original e-mail you said:
>>>> I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm
>>> The ath12k driver does not support running in a VM. Even prior
>>> ath11k-based
>>> hardware doesn't support it.
>>>
>>> For ath11k there are some manual steps that have made it work, so if
>>> you are
>>> adventurous you can try doing something similar with ath12k. Refer to:
>>> https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail=
.com/
>>>
>>>
>>> /jeff
>>>


Return-Path: <linux-wireless+bounces-33291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEEmG2HRt2n0VgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:46:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 078842974D6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6957306570F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088A38E5EE;
	Mon, 16 Mar 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="Wc6yifjA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9538C428;
	Mon, 16 Mar 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654072; cv=none; b=AaeyiAKTTd1iIARVSQwWogx4X6f4uzkIlA9mYfIaQqorvAA9jWMO+vOh6WmqpxvvT7YLM6MQTRr++Xy4SmUU95Ye/2zDx/M+Mmp/30Zv2Gj7t8wS+GDShh1X2PlXznHYHOpygAgg5TCSjunISAhK0nSmRaVcRxpP9Ea8pLsMqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654072; c=relaxed/simple;
	bh=oE0fMlEefNeuoIcjwc1NoWekLeZpE4jrO6XSYGJlR9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu406b4in9DN0c//t4XUKqiDRudkDUPn4jByvQYHVW49wBMdd1aL/M1iq6ax+/0p8ya5quDJSbpjTegEKKBcnPM6IjuRUl/t5oMBw5hXVdU6r3Xk3b0K8KGdGGtu3N7Ocud5bh6GR3JNCwdpln1QJLh/uzMe/wwQMY+e7nr/+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=Wc6yifjA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773654068; x=1774258868; i=georgmueller@gmx.net;
	bh=1PNPHvnoOQSTFu0MqK88rOhdnSk7GIg477mAc6lVJpw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wc6yifjApbOzW3+rKDIEyhG3SmZ7IZ3NxNPGEYpYe2wHy6jRpiI2SyU8eUTdS5Z8
	 jkfYCzHL14iV40ATIkQVAXQdhcvrhNMyWy10Nu3IqngiNpWw42mPreS2E7pnnS4Xw
	 kDbe6RB/OKeU0qosugHk2YmZP2LH2i2idi7RtEKziRjSWHjPW+yTCkQ1VUAZyGNLZ
	 4Iea4LpwQRrk4BQru1YTMeX7N/KI4W4uifFnRpGFx6TpZ8ZaQrg6Q6AgiDeM95BKv
	 0W0N+LbHfluA+x0swY82W9pv66wpZCe1n+IoSiLWqM8tsnhEGbOIec7fC6+seLwxU
	 AMDSwa/RVbRJuNPb7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1vjRdH062l-00sv45; Mon, 16
 Mar 2026 10:41:08 +0100
Message-ID: <7c4bee98-5997-42af-a7f3-2821beeab512@gmx.net>
Date: Mon, 16 Mar 2026 10:41:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] wifi: rtl8xxxu: handle rate control for 8188e
 a per mac_id
To: Ping-Ke Shih <pkshih@realtek.com>,
 "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
 <20260313135321.3196688-3-georgmueller@gmx.net>
 <34bfaf9b86184047b5591d03517bcc7c@realtek.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
In-Reply-To: <34bfaf9b86184047b5591d03517bcc7c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RRzLxtQmVJ5bU5Yb6qi0x0MpXMfP3zDsVjMGIgLZc+1s2M6vxvJ
 I9tH8OnvlQBQZyquwov5tdB5zeE0Z1IIycWqdnre8AnVmDJp5+DjhNvG3EcrqvOxDoxdlAX
 xYkNCqtboIPHDCLIbZHMoZHIX+rXwQ1tx3WMdx0+3Xx9MXdY8aUNBPTnUDy1bcRIk5iqy8F
 FFjJwZcbK16Du2Qk/jS8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:spgmsx+X7hc=;BZNO1SLzwncgS8ujOVnKqNW/CZ0
 QWuwgUPZJQ3hhOnihvgz8U99b0UfW8gLk1VTshs72rxOrhKTbbY+b1kN6ZT9DDj5IkRU+n/B+
 /TTCYFkT+Sh3U6nqW3t772jI+J1U4IoIe73I5ikFcwEKTeMBLbtLVU0rZShlPs1UKAX+bZkp8
 ppJER5yVD+7xN6+JtuVl7lH5oW+R/EA4JrOOxKnpTutbZQ9yOpC99NXpItaTuE1he/CCIiKFn
 XuP/Ob9MVV/itLlv9qtTUSS4rMI7AI+gmVHAH2Qk8FQNCwvU9AgUKAOQd7CNtVTHplDNUmPbW
 SnxHWF7HGYaYhjjUuzQCzBJk/VAK1NmmOkf5na5nZIQKw4omWolNdJpLSdZdrI/m35kxsP5Fq
 GGCOOh9LIss38ByWhzzgvVFFyZpk6R2bqiO/JHHxDQYhOu8/FHK8XxAQ8HUig7clIjXqLxOir
 I5kfYQNySQ49ePwDHrIEpFNNymicc0rYUxx4wVgqNk4t3eIr78lobKbhwJYFMYEeuYwW/UxrG
 B/uvZ45Zl/pyJj9KtP9KJkLuPzjZMcI9cFxHhc5jGzoP+Dlj89dpmJGAyCpG/KMEhgZ08CDF4
 TgHyN20UgA+hyAwEqXFJNrP9sxvKOs84owKCvlDvA3xzK8Rtv7xdK1GkiM7mKK/2wrN+a9PuR
 eNvnpJfghi80xY9aAGGFgjJ5cpKIFy7WYvvwCYNVsZYoyZKmYZFKVfJmbsDKVDOiXCpxibS8Q
 tOIRjX82qbWWzFf/nSYL2OSggFFnzBymoV/wl8a/C/bhoCgJTMis6/HoZWEXBXH8D1oXl+8sg
 E0SsS3TDHFg13Rz82K4jkA0zJKkPEoSbcL560H1T0ND8auxp/gTuoXPR/BAfybTacG6gCjiKk
 p0gl+0/PF5j8k7VBmjPma0imYTynQbqjDQaiVwg254maMN/f0gtyZOw52p2vrnRLxmzuTeg2c
 mA6mUxVA+cyiNFpg+8a7ILq81vmDbrceweholq6eUhZjgu6E4wrM/2MtD1z4xIVSkEUGPOW4h
 aZQPUv9lvd/tPqajtj5SJLm8Hb2cORCe7m3sGoUfBtsfVQugRrq+xbG2yl/hDmijTuCMsF9XY
 XdStw5R7aIKQIkQ6jUTuVDhlXOdV33X7kPCNLQ3rmRtuKuQLFpJzd3ZvrQm8kpktlbs9rzQIb
 vxEpOZQc9jZfUhCK3LqGfiH4DZTMLeDW+fDS8LhrFZQatYdPihGyjRwshd92XiQw4hsy00K/T
 uNVE6rkfIefI0sncZd7TehafTFKf017UGHDilo3jlEsonx3jhYPRp5T+RKAuAmmtkZq0RpoEz
 plZgIkg+lE+F4liSeJwBBztP8dAVkHiSTxKxLoAKNxpCpMkA/CQ3L//m0EPIM6wtY18W3944N
 QYkGsUN25c+V2N3YnKuHfrPqous/kly1rdbdyaZbrTW5GIwDRPEd61dI0pM7mjtc3qxQ6wfmd
 G2lIbtv45jWYmUxX3JqUm6J4UVdeSqV8SFjaA4p5NbGUlwIrrqmXLLKsZwMYB+cTTEG7aNcQD
 c+EJYzdS32w1jjGcraojzRqalpoW2Icl4VxSnZZKs7z8F/VSx+6VAi7CYz1nbf095yKkrDxxE
 2rxgt8MCrqyaLFy/8durAoWHiHhOyc7dhPmRaMUnNXyPGh4RoThipzsxhpz1iSpBWsPYy0thu
 RkRtdLGihG0w2je98bRHFLMyFRNEWdD93JeR1z1f157A6kp3Ru1hyHzhM1L2QIWL1NvqMFsjd
 BdsopPjIbdNTTgtwZPvckYKMIsA4gHuL3SDsWVpKiPgbjvr7DchQzViD7mAYyB4vQdqGrmwsb
 99ENoWzT8ke6Yt32hlCcOXT7fC5pz+Hv0oYwjmdsyA6K0nP1WgLbF4qYhJaVdZs+lqiBrwO06
 KwDTLVP7eTLKOBr9wBBlvFe+Y+CKE4pD6KDz6p3M2QfEZ1CozJ1fbLdABvG8Vbtk18yv8ynVL
 bpynJsarymSMM6FEE0XFGPtrTn3NqO0ikuNfsYrMxjN6Z6YgiVBPqPpiuiLPBIxiwde5oCN+P
 eHKv9u3A3w0PLhijQaaJSWlkpZ8wbOn0w2zmEl3hayU6Nk5VnhW3LZ9sZalaPTceJBXY54Un+
 xuV+G5LoQg/+jHtXg0TOmkKdI6MHWdqxOkbXQVk3OXgSmEgKvlfeU5Pdp9xrifJjpPHA9uR3Q
 iiAayuof9xo/oA9jO0GUyx7AzwM0dZFPPtn3cNnuhxtEG+cCMJQ6kcFf8Z7lQLr1QxNonfHga
 zanzCy3U8JLIjUjhlLmSd0anxYBG/XutVL84rIvjs1l/++hqfPlEaJPtjCYpYum1OzsOaQA6/
 Sgyhxj89UJjuT5S6zPU6Jnv5br8CRig/GIBymeU8T+2KLxKZt9kXnQ7uddJxKZTWZ8xAs6mRc
 a7cn9One0mBrzVjKyJQhBqyLnRCH/fxiKydkzaPXPxodYDtkW27xV5BxPQJaZBr+3ciaUrO0A
 I3RC8Lzw5Gwz1G6QxRLX56staWZg3yX928gdt8pMTfL1oZX9chZZn6hgIBgayT2murSsDJ08/
 Z0hHrnPyLgtYavfS4GbfOo8a5sfpg8kun6CvprPGKmH/ZluXEWBx3Uu+sPxWPeryHDBn7vpsx
 BCCBrBVZgr+eAWAozLb5cXFalgWpYRvNHHS7sfSgj09rpQvQtFliJpYqIww15lVeOWYJIQM9E
 xcY6Stbszlc/AjuIqJk+qorZt6al6/ZbkKuwUyU4OuYFEdhgVHC/7aMSbctOx+3V1Kevv12Fu
 tAynFkYtM3oth/4CTQuoIBQJvvGHIgfyXr0d+brryo2uqr09k+UMAAqGkbVWPd3l+wGC+DuK8
 YoMYsr6vdlMBDpzlTPlrR0mpNXojpwvgIQUpbBZAb0SvIQITJwmH/EIl+bEuScs/Wk462nzKH
 BbcgToZ30vt1pPdFA+bmuQoeI4VnUy24YXBhkl171PJqrCim8z1p1LfOi2gCF9pRBPokPnoQ6
 Jk3KtTFn1+FtcTL1MnZTdfiOinbiBiRQ/x2Eyf/znVY/zCMXr7PN1Kp6W1n4IcrO2CX+OY52A
 9G0JaXhKZdL5/ts0hOsnquSeUzuTQxgC5AYB0u0/CLJNDJAHUmc4j1yVjlh5ZXQxtumpUebGE
 mNzKzaPpIhzY4pzjgGyzCukWZg7rSloIKFR6UmvHMhaf+jI3YDdToTBeFyGcMFaY3AHBbE8ew
 bYIddkfYLPc8YQrusC0rW8+8F9PEYitmZW7zwQPOB/orMz3Q7nq/yZxwUvT9VIiGg0jEWB8Ee
 4bDIWR3UlNWy0OElXafVdfkqv491ApC7LJV7G8mZAraZIeltl2GqEIzb61+gFJ7VzJn8OFqr1
 fQ/PQ95FRM8q+ZquXzMi9LJav3y8knmN/bjB5jgKIv5nGpIRlMDA4YC9CQoaHoZSPnho/2zHR
 8EZoGjm6w/UU3DMW2d8ENENnct9u43/aMU04ZO51cE3Q57HXkJAdIoACwffuJOWNkfMMlFzR8
 AeTh7PE+nyf+MR55F5UVSBYQBKvbM8JAXoUoBLI5Cgm5YzOXkNzb/uXfDAeP+A4EsO9BfJcM+
 jl3zFrMBSZPsjwKv6JdtjWXnFb6bxt5FxMirsVv0EHKBUN1FoAPKsIgtjdAf6mBVZac11W6Fc
 ROPfXGQAqQegknxAcz68xXBDYs8iVc6ojWgY0vX6h0ViUyKWx+ubmHMby5X9Exc4sO5sS6SOz
 iAKz9Et+J0DUHosf6kYOQJfLSmHgdvSXCmAwfhcgwv/33yRu59NtDLLuFMvbbLiFw2/6Pp0Ia
 stLHsmxqfNBpcezrLjrFPmmmaO1ipqerrW1KDSD5o4Ov6n0p/rASMy6Fj2ONnpt+40Nsy3H5j
 u73hZ09SsvjKwQcxw9SCDfFj/dOmk6D4EuMNBjTJXrqkQy/MixjkXoIAYs4Tj8pheIw/Mlnre
 Gt34bUgLxoUoFXtFIcvEsyTL5o24f4A4Mu1fZr4XBvLF2RormbcgLRuRTu5GIqeIDE99vHA9T
 s88koSyu7eGwXvLznsGnk5tItHWYMnNf5bfZJ1il1DLkUvQV6qZUVMhQmfVCxlE4dwOlBuQcE
 6FjceOURtNni5jOLdDPw2NUNToBcPwOxtfU+DU9zS/XDjVQFYTZddYFtO8ODNn5aYXtgZr91D
 zshhOeIX7ovKoVSqOvhsGK3gxjyl4FmeKP34AcLUcON6Qaq6idhfS9UVbtYe1mZH8VRNvvw+F
 9RLzRBPigdpC5G3I6QPPPjkBVS0Zpjj1KHX8P9jkJY5VY3Sb0s5ALTZuepE3MSD/UKte97EIY
 rHPKmsbb85p3Sdz4MiGT3Zl2EfD3K0kbKAYjKVGuxvqhacn2d1VHwIrdP00v0eumUS6oepVKU
 P7cdbEZfYr+BCGdHjkyAc0jACQUiFBz3iiCr1gbbecEyU08Oe0hTdB0JFfHsT408bcbhGN3wt
 Ei8zOtlQsY2YZHZKomtYr0BxuyJytD4lNLfLSILAWcx7eelWrhCFJD3DAum77x9EuVXXmvvrB
 3o0/OkpEVr5to8/FEK+FRI5YthRO8xyv6d+8Rf2zgZR1zHljcQaQrR24RIVGlEkkpThNdiLF1
 sd+stejNNdqVF5EGs5t+WTMmSrvcoNOB2Fv2D2aQF7hqqVOujUpLLExmu7LMClgS6QU+I/NDM
 eDE6Cu3NKoTQ0GjrpbmwSaRZKccank5OXt0g2buVfQixHmcVG0j5HfSS53UsrwKfXrPxibviA
 56ntoC981NC6aTKnZoWY4teDDa1MOAY/iSCPEPiuHoKbb7UfjNhEBg3dnzaD1/x3knB12KmtZ
 PlwJHzuKrv5kdD9cow2Hc0GHDFNRBmDWUVU/C2OY0zs1Hhxbymybuu+IWZjIjBk+IfE8+aVqi
 isPZ9fycpslkBQiyCw+fFqq6kUARG8ShPQ57+lkTSNj83D02QqgBCiFBmd1cLZgheQ7x2li37
 8lzhBiEWtq2Cl39RD6+eNF6M9n25/onLXKx4rv7yi5ZyBDUEFGUwMlb2dz7/JqUz0vHejVdyO
 hpFezWop+3bCsbDqAHfs4nIvn5kAXkoy+RRiAcqFtUtnYyrhp/3tRP6nTZbpPdyaEzfi/Y0hj
 S5OU8hm0MP8v2VBg2nuKeeIsLHKoQMwdBoM/KyG43+C10dSh7IDR0w+GTwWSDcyneBPInob96
 yTAFH9r9gomE9bR1zCyAPa/+ayYngtXRKJer+POI84uFdW6SZ3eDkZ1zQ5hs51ABSEOXvn09o
 5pxI7ghOZOvzYOKG9WNFAJGJGaxs1Dis6CdWLnrhEabJHD84pCFAVYl/pN8UAU8IwiKhDALdN
 /nZ708e4fRjdyEKMXRejnWlOFhtBHlcWEL6+alGAgJqBqEDzVuvSzlx6Hl1xGKYCsikJBKrnq
 RXh7NQOfVFtBtkgSK+rZhjTs/MBU9KVUw==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	TAGGED_FROM(0.00)[bounces-33291-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 078842974D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 16.03.26 um 07:35 schrieb Ping-Ke Shih:
> Georg M=C3=BCller <georgmueller@gmx.net> wrote:
>> convert member ra_info to an array with one entry per mac id. This
>> allows having different rate control settings per connected station
>> in ap mode.
>>
>> The max_macid_num is conservative. The old driver used 32 [1], some
>> other sources said 64 [2]. I have not enough adapters to test any of th=
e
>> higher values. Given the usage of this chipset in nano dongles, I think
>> the 16 might be high enough.
>>
>> [1]
>> https://github.com/lwfinger/rtl8188eu/blob/f5d1c8df2e2d8b217ea0113bf2cf=
3e37d
>> f8cb716/include/sta_info.h#L28
>> [2]
>> https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143e=
a20c@
>> gmail.com/
>>
>> Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 12 ++++++------
>>   drivers/net/wireless/realtek/rtl8xxxu/core.c  | 19 ++++++++++++++----=
-
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++-
>>   3 files changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
>> index de2837a91bbe..607ca62194fc 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
>> @@ -1468,9 +1468,8 @@ static void rtl8188e_reset_ra_counter(struct
>> rtl8xxxu_ra_info *ra)
>>          ra->nsc_down =3D (n_threshold_high[rate_id] + n_threshold_low[=
rate_id])
>>>> 1;
>>   }
>>
>> -static void rtl8188e_rate_decision(struct rtl8xxxu_ra_info *ra)
>> +static void rtl8188e_rate_decision(struct rtl8xxxu_priv *priv, struct
>> rtl8xxxu_ra_info *ra)
>>   {
>> -       struct rtl8xxxu_priv *priv =3D container_of(ra, struct rtl8xxxu=
_priv,
>> ra_info);
>>          const u8 *retry_penalty_idx_0;
>>          const u8 *retry_penalty_idx_1;
>>          const u8 *retry_penalty_up_idx;
>> @@ -1669,7 +1668,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxx=
u_priv
>> *priv, struct sk_buff *s
>>          u32 *_rx_desc =3D (u32 *)(skb->data - sizeof(struct rtl8xxxu_r=
xdesc16));
>>          struct rtl8xxxu_rxdesc16 *rx_desc =3D (struct rtl8xxxu_rxdesc1=
6
>> *)_rx_desc;
>>          struct device *dev =3D &priv->udev->dev;
>> -       struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
>> +       struct rtl8xxxu_ra_info *ra;
>>          u32 tx_rpt_len =3D rx_desc->pktlen & 0x3ff;
>>          u32 items =3D tx_rpt_len / TX_RPT2_ITEM_SIZE;
>=20
> The 'items' should be smaller or equal to RTL8188E_MAX_MAC_ID_NUM.

I will add a check.

>>          u64 macid_valid =3D ((u64)_rx_desc[5] << 32) | _rx_desc[4];
>> @@ -1688,6 +1687,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxx=
u_priv
>> *priv, struct sk_buff *s
>>
>>          for (macid =3D 0; macid < items; macid++) {
>>                  valid =3D false;
>> +               ra =3D &priv->ra_info[macid];
>>
>>                  if (macid < 64)
>>                          valid =3D macid_valid & BIT(macid);
>> @@ -1704,7 +1704,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxx=
u_priv
>> *priv, struct sk_buff *s
>>
>>                          if (ra->total > 0) {
>>                                  if (ra->ra_stage < 5)
>> -                                       rtl8188e_rate_decision(ra);
>> +                                       rtl8188e_rate_decision(priv, ra=
);
>>                                  else if (ra->ra_stage =3D=3D 5)
>>
>> rtl8188e_power_training_try_state(ra);
>>                                  else /* ra->ra_stage =3D=3D 6 */
>> @@ -1781,7 +1781,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *p=
riv,
>>                            u32 ramask, u8 rateid, int sgi, int txbw_40m=
hz,
>>                            u8 macid)
>>   {
>> -       struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
>> +       struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
>>
>>          ra->rate_id =3D rateid;
>>          ra->rate_mask =3D ramask;
>> @@ -1792,7 +1792,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *p=
riv,
>>
>>   static void rtl8188e_ra_set_rssi(struct rtl8xxxu_priv *priv, u8 macid=
, u8 rssi)
>>   {
>> -       priv->ra_info.rssi_sta_ra =3D rssi;
>> +       priv->ra_info[macid].rssi_sta_ra =3D rssi;
>>   }
>>
>>   void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index 794187d28caa..5ad23c5c9305 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -3921,6 +3921,7 @@ static int rtl8xxxu_init_device(struct ieee80211_=
hw *hw)
>>          struct device *dev =3D &priv->udev->dev;
>>          struct rtl8xxxu_fileops *fops =3D priv->fops;
>>          bool macpower;
>> +       u16 mac_id;
>>          int ret;
>>          u8 val8;
>>          u16 val16;
>> @@ -4393,9 +4394,16 @@ static int rtl8xxxu_init_device(struct ieee80211=
_hw *hw)
>>                  priv->cfo_tracking.crystal_cap =3D priv->default_cryst=
al_cap;
>>          }
>>
>> -       if (priv->rtl_chip =3D=3D RTL8188E)
>> -               rtl8188e_ra_info_init_all(&priv->ra_info);
>> -
>> +       if (priv->rtl_chip =3D=3D RTL8188E) {
>> +               priv->ra_info =3D kmalloc_array(RTL8188E_MAX_MAC_ID_NUM=
,
>> sizeof(*priv->ra_info), GFP_KERNEL);
>=20
> How about devm_ series? Then, no need to free on error path or disconnec=
tion.

I didn't know about these and will change it in the next version.

>> +               if (!priv->ra_info) {
>> +                       ret =3D -ENOMEM;
>> +                       goto exit;
>> +               }
>> +               for (mac_id =3D 0; mac_id < RTL8188E_MAX_MAC_ID_NUM; ma=
c_id++) {
>> +                       rtl8188e_ra_info_init_all(&priv->ra_info[mac_id=
]);
>> +               }
>=20
> no need brace for single line statement.

I will change it in the next version.

>> +       }
>>          set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
>>          set_bit(RTL8XXXU_BC_MC_MACID1, priv->mac_id_map);
>>
>> @@ -5338,7 +5346,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, =
struct
>> ieee80211_hdr *hdr,
>>   {
>>          struct rtl8xxxu_priv *priv =3D hw->priv;
>>          struct device *dev =3D &priv->udev->dev;
>> -       struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
>> +       struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
>>          u8 *qc =3D ieee80211_get_qos_ctl(hdr);
>>          u8 tid =3D qc[0] & IEEE80211_QOS_CTL_TID_MASK;
>>          u32 rate =3D 0;
>> @@ -7895,6 +7903,7 @@ static int rtl8xxxu_probe(struct usb_interface *i=
nterface,
>>   err_set_intfdata:
>>          usb_set_intfdata(interface, NULL);
>>
>> +       kfree(priv->ra_info);
>>          kfree(priv->fw_data);
>>          mutex_destroy(&priv->usb_buf_mutex);
>>          mutex_destroy(&priv->syson_indirect_access_mutex);
>> @@ -7924,7 +7933,7 @@ static void rtl8xxxu_disconnect(struct usb_interf=
ace
>> *interface)
>>          usb_set_intfdata(interface, NULL);
>>
>>          dev_info(&priv->udev->dev, "disconnecting\n");
>> -
>> +       kfree(priv->ra_info);
>>          kfree(priv->fw_data);
>>          mutex_destroy(&priv->usb_buf_mutex);
>>          mutex_destroy(&priv->syson_indirect_access_mutex);
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index 4a744b5c1aec..9ce820ff4793 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -76,6 +76,7 @@
>>   #define RTL_FW_PAGE_SIZE               4096
>>   #define RTL8XXXU_FIRMWARE_POLL_MAX     1000
>>
>> +#define RTL8188E_MAX_MAC_ID_NUM                16
>>   #define RTL8723A_CHANNEL_GROUPS                3
>>   #define RTL8723A_MAX_RF_PATHS          2
>>   #define RTL8723B_CHANNEL_GROUPS                6
>> @@ -1915,7 +1916,7 @@ struct rtl8xxxu_priv {
>>          struct rtl8xxxu_btcoex bt_coex;
>>          struct rtl8xxxu_ra_report ra_report;
>>          struct rtl8xxxu_cfo_tracking cfo_tracking;
>> -       struct rtl8xxxu_ra_info ra_info;
>> +       struct rtl8xxxu_ra_info *ra_info;
>=20
> It looks like this is also 8188e specific. Could you add comment by the =
way?
> (but please /**/ style)

ok

>>          u8 dynamic_tx_rpt_timing_counter; // 8188e specific
>>
>>          bool led_registered;
>> --
>> 2.53.0
>>
>=20



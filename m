Return-Path: <linux-wireless+bounces-33215-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC6cNdsZtGlLhQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33215-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:06:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B97284834
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F0EA30C4025
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7968264614;
	Fri, 13 Mar 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="KPO+LMIB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60D38C2C9;
	Fri, 13 Mar 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410010; cv=none; b=bCr2vcYojEd1DDv/7sbylOyWnN5OIf8xxZ48GIYor99nUrNLqJjIT4NgHdMpqxIg7RDDNZSgHKp0Pw+aRMIsarNnGcQieJTSfFtuRIQr3H0njFt1TVVcFxSmzqPNaBaPMmrTfc5Ezw6yVASQ8Uzi8g5NEm7EYGNekYUb3veT8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410010; c=relaxed/simple;
	bh=7bG5nM9CE3+hTPYQRZqiMk3qVLIBXFZvR19AD7vIQUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PonKpbIbZkMLeiJlSDPRdZNj2BfnwlvrH/oVAm69YQKp+beH+bM9RVvvDlGic+mqkFzm6NnhYQV/MERsGroJMsKlrnyYep4QQY5Ezgahuz824c4WbNMNELhwdQa0T1V07cpB+D0p9I4LKVgebW5dr04C3N/1+YogUHj/EbkpAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=KPO+LMIB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773410003; x=1774014803; i=georgmueller@gmx.net;
	bh=G4yeteod1HBB/BGDga24yXhiSbfRS+ure4I5ZT4gPlo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KPO+LMIBHv4rbOr0yODv+Efrx0eYd+fBKohgRpX5MqFwyMcq3aQa/M7A39nYHs7y
	 j3T8uBjdp5Bjvp8WMb69YczMIpjp7CWjjae9EhjcdbkGFKLwlMlgOV+LEO4pNdRBn
	 c+hSkHXnQxvgkwlDEmsCEeCmHRdh4k6YvXeZDnyK40aaJ+E7cTwbSljnBXe0fxxa0
	 O8vF1t97WcqnlhxIhFQCkVIYaBoCaggfmYQUdZzfHkSuxLD1ZEplVs23kUSzNGVY7
	 9JPQ4x4djIbujgmjPq1clPucaikzz23Oj6xtfWG+0D/oF/sLhIXODtfh5lle9/Off
	 0qqFh+iuUGBmdEdHdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1vnrfv2PWS-00E9Zi; Fri, 13
 Mar 2026 14:53:23 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v3 0/4] wifi: rtl8xxxu: implement AP mode for 8188EU
Date: Fri, 13 Mar 2026 14:53:17 +0100
Message-ID: <20260313135321.3196688-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:31Mdqzf3zg/1XaZqC6Fd1xpnUXrz46I5XNQC/mpirAnAR1398MP
 94fGGVw1L38rhLYFSvbkLBQZeKS8oTXe5mp1IzwKEclsxPQwBJVHkzcTvb2SwIzmttFJHYe
 KIkDHgArjw3BIyrXgNOeaANmlBIIIa/aq5VoVkzlwFABHn4pEryW2VoYuysPSLX6sz9SJCG
 pyW3MKHFO/hTQ/xULq63g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SN85ZOKMTA4=;KSs5Vc4Fah/FDtIrlyl6F0hXSGJ
 yh78ZvZgn/RMSz0YCpX8yYKzewI80+qR1+fQfr0/ZWcwDxgXiHeu0+dAgz487n44m3wNz9Siu
 47kX8MkA5cwrXqTVBrOEsYOYF7gS014r/S7M5Ryj64wVWKPoDuaWzmsXcqHrs2jYUCPrlmdmN
 Z/3NXGLSvWJSlEXCBLyCpBL+AsPSUnOTJZJsxaq35VXXKz25zDLCbR82PFYonBi+x/QzLVJHm
 FCtv0s05ZQEGtw4RK9QvYR1cNxNnocwPnDk6WYSP+4yzyXFBEmUPW7UoE0NO71992fGjbLeLd
 aMNGRG5G0IMGyCTQklgS3fZ3dbS7XCbhvfj19cktpU3aDpMM782LX7PnyYBd5c8N2vu7wFbDp
 q4KGy6BBPMufe2DOHOUgPX8WI8GknINCuHL5d0J/JXxXSMv6M01AdOftisE3Vcm4sx89CH1Mo
 3fsqK3OBK2Y2bSFPgzHV59t6EwrlNq9NlJKphgSp8Nb8HmZQgTTYf5KmKIm1IPzgb0J6We1Do
 SYIGucWq3myDu3zbZdgbg0V1o/W+3+A5RlfPBaCp/cJXYgPJXowSDy6vtzHq9yP7f22RQVtav
 b3hFa90wpMgDBezMUzEzYcjaY5AgbYHh+6wz+Z2N+MnUbfyybK1wLEoHTqfaBjN7RXOSvD8xW
 gZItrubnI2aQ9pfIv1uRdx3EavYtF5I6k5N665yu19LzuSxzmJr/Le8f0E3V88MV7A77WFHN6
 G6X9TP06TECQmQigRDICkIrVgOVSkNsz4NnwiHXfHgb7076vKVvDUJ/7lxqK6dEStLCfYb2Ej
 UQ+f7hVfIcu6wmpq+gsLpA8xVclibCL/lN7gD1JYjenobKYefPD7lYDVObzBSZSGDlChUJBOa
 bsGsL61D2AxX7bb2BmPD1qgcgg3fe0TGWDAX4jT2k/edW3TVPapJCFAvC4vYKH6FfoeilGcYL
 xThxeV0ulQk4msqs1lYhYPtNlf7ziqlbLG5VHv8kuil7hYdwbqGHxXezw7GIebfOnF8SVmDKd
 Q9a6a9kf/tM5QxduAqvcEz8i0u47Lo7HtoSdO9NnBQDjdY9mJXpUN6MBxpIxZB8hVjNDDtvyW
 NqiIiOd++7U9XU35ZOTxkIF94wddVcn1kaRg7ejjUEChRMBQtM8I1/IpLIn0APwlabjtpA2sW
 MlJz9QZFrCcgin573f0of7yv1ksIWePL+xED9mRHWLCJBxubD6NES2Wk5865lBT3PXCohT41k
 eREqlk7hboOElPi8O3trwyqtTZlSc3yR25smbOeiTmwSNwJ3c+8R9OBB269PcM0RmSFzgHceM
 Ez6uJ6MOP4JJ4ut16mJDfdMaklCez2/pOY0rSsftysphSGVyCTrxtUTXLoGQ3UAqBEsC6f/KX
 MGVnvhUln0Te5mYYiEp4psQy9zCQIRyo/aoasdXrM61GLd2v/mfo9ok08fpAbL4gP9m1TQsB0
 RTn5fzgrWGqhOyqsdXQ6gGgCE6KJOciPd5xZD8xvCmZNKF7P4tW6h95fxQOk0sPLKP1zHX0c0
 DZ7jeEKzGLbqYk7uXRZcLkvaOHwPzPi8TIA3uUub4jdvrKKVo8RI+UaOPFQXaBgb9xbvhXf0V
 T8IHAZ9KV/UCll0p6B4L+ruOeJaVNvmQ27C0pprYb5laBJXlQritGkz09j8EnfFODoJOxMb/8
 gO64mccsovlkjYdjtKQCyXcwmRVf9tMVrGpuUpVmXqvQ6lndWO3sWPGmRPqMN0XJGfes8vkDq
 jYnhaBG6bZc9wl8CyeKOXBN0cvC+OU40acv9gZg8CJ+g5AWaDK8RfXtO+J/H8R/m70wyOxeZA
 N9blWuJEAMQxnkajw074Th/FZoY26H6PJwRdgcHeS5ceeBmxUujRf4IB8BggXQWqSMWwW1GWa
 9BF+xW8RfNjSDQ5cnpaUXtUwfehuqMa/Ca+tCuamleDZjdMT40qdhNla9nKP20I5QLORk6YJ0
 4te64naNZKx6aT/DukSft8XdtN8DLlgrTqviU8ryxQshZuMoJMJt/hUMOoVmsggxmh2vQXJ67
 /PXYpY/ZT1P7tFhtqbe56w+jEGo/K5K+ga8BY2w79QycAQCN+ThVmE750tAdqV4Fcpp5L/cOX
 mLaWvjU/ndKiHgXJp5tkkY7L/C/UGN35DAKEh02PtlowVN0kgxSMHDTn8CeWoHir6MK2mrGs2
 39ZnQATdH65Zw78nDt9GX8i6ddouCgq6MV1D7tvsUhtQmUqfgrSUH2j3qY4v8QmSmEPaLAq09
 E3+PIbP2dqUrDqlYNT4N2Lih9LRCgNl2N4WCwSV6OT/c8rl1h8G0vSelg7cs9ur//ZVHxy0Ts
 Bu4Nv758zzImcp5NsvMaJF2RT8HYm+ftRePJiH82wSZOuVROs/zKs4+HmWYM5+wKnOmhID2WZ
 srmA9X2e1oeL2Q2cOVQsDkxw7FtHV3Jq3Yq2j1/DkMUYqB0yxJtiiOJ+nNOPbgsVeyGABVo9B
 NUYQoj9DM9Hf+ucrYXfIOEdGzX20rsgRk8IQ/mCQBKQ973eptXxGssrzvfDeQUyB7LRoghUc3
 icx1JkFgsbUhVkEUWpF/QhVLeWh+w7NfkjFBGeWxlio725875rK2YLAAfTiYdZgT278bcDPUH
 5oGrZLI/vk2+c4ltSe6XtuPurCLy4Z5wIHdOCrt6szbb0zJL9azwg06OqtyApM9PWKmIrdfNb
 +TO0Sa3NNxxTmf1OTrh+FPb7gp59pZsHC9AwMt+BBsX2Lu5Ff0Nf5RxiPrTst1nQah+3ZZZAk
 1KdhQGvDaycvfwLIPQtAFPHLztqH42JX2GJCjcv1H317+Z8uTg2b8E6vmgGWms2eZ2UcdMBOT
 m1vLywT/NsHJmay9SvNqHv03YgyaSTAsJnj03fNhofiPYiIq4RaGCrM7JgLy5Ltw8/iqLGkJv
 xPlCOvzUXkdCB325aoB0fNibDLtB8c+nCNc2eZYlaGM+WCjEzLM3Rj57t9vHvke0dV1e+vFyp
 WK/+b/gqrTPKstTGmMmrrH79XMwrIcx0Jc4BqmXqAA995pMXoxBbyyQryci060X+ue2wc0PF5
 D6jZB04q1A55Ll5zqExisy0UOm+CKNptCwjsjLc96b0DNewEjhHhCAV2hDhQcbAhq8EpTaHsW
 XmWg9Rj7bcDL5QR5XLXNZ5h+PT595StXHBQckeU4Ura+Vs34nKwiRc8Dvn2nq/XQtrJUGOfev
 pE8tbN0jlBOQv8rXGuCkKAq+U6uq0I3AV0WFaYt4N/qM0xaofc9CjHRbzkfTYyoyTKOfVTh8G
 2WXWoc1JMP3GgN/6xMgbCcPGB48LncIEc7xyZ7o/454bnLMXuaDl1fM8D5x0NLdnEGyUzvNkT
 0gStPrOJGbf305tAGuh3cfuCTIdGWr3QMrKoU0f5iX03h2SQTXEL148EKvsHvpQz1JvaUHMzD
 EbO7YCq/hQ6LoOWncu14mTNXQOHkYzaUBleUvq+Hz3Ut6A769GneOMqQcbTqOQLqE5Kw1A3Rm
 9AO/CFEQOoQQwD6m2Fcj+MG69ImSRMg2YBv/HqNQFsgqlLeCLDj+q2awVWXC3Uv3MH36yNxeL
 C8IhwS7yXBfg7W2sXuQTtomxTy4O0U0qNKSySJlpXQOmwzmeWxnBlkctXpfhPj13gko9xjo2z
 O8HfVDiFteNXXj60OnTfUMXMikMcq5KCD1M7avhOnhBzpRaxRBVlsuF67xhxn/+ltgAH4i+mU
 Xf6gXU3ZqUlMRO7dlXndNv+FZYjNydEms1GWmSkRcfbWkkQUeegPBXZkaekVnhwyqx/QDjjr2
 b83hAhPHwig+Wy5AIwJ+7cXVK4Z1au9g2WnBCeTmzg06oi0Holf9KRfdFw/ecw6OTRvnBuTen
 XhkZhr+p7UTBSSrfxukcxCMGhzPIu40R4YNsE0yLD2qATveD27EJKPZhE7A3s+izDISpchJb8
 u+W9l489hgG51fmI5EnzngUEo/NWfkRVhBfLd+8jjc50rmRvQSLTFvJTXH2rjQ4q3Gr7s3TeM
 SQ3b9coh2FdES9rj3uUssXFzzFpxd9mhk/fmr99Nmt0P3NKuLbQlSpHRqD1+cbSI/XuGyebYz
 ExE6ZhBEP257I8tYkeCOt+LrJvgb5TwNHN7O+xHWGbJ2/RzCNtJ82ED8hrgL412l3wKP2jseY
 fegOuv++C3/iJ8mgIzkVv55GmMDSePflcZYAOcCCX9oQHVmW49GfqK/cwLq/Ic/J1aOH7/170
 xiQI3zuV85LFdU9V7hwgG8bT36oFZZTl3xFoPx8ei93cpCUTlfI/RlBrAUPufuGju6GKDkdCh
 R4B/ThInsug661eUxwA7BpAywBdhJPUMVnsFkt57cdrKsn4PZN/JhOtSEDkNVvPCH4JjXNl6B
 vHOuugip2NrcSbRwdQu5MEue9IKy4yZJ9NOGwculC4ss09kSqt7K3VNSMJXBL97WO7YOdHHZ5
 Oly6Ecp0lUUZwUU7gjLn/7GrjvVTu7WvlCPQpCnqeZk8dmx22pkJdBD0Cs11uFDd9tByutUDw
 1j96nra/wJcSP6B0zxLpUy9t9mUlKRwho3cGG88p/65pwKOQLqep3ET4NPb41RQAzq3w7oUI1
 TAw7vli0MjVU9KMedXA+oItcnkaUdLMZIG3+YX743IyyqDsFtEFDgRu8oFifnxFtNQeu4sIUp
 jJ0eo1+l+Q4LaS2cvxpY7gQuPl4JO9PyDVPuzJYpYgX5CVq1/PJdLkGeTAzSbmnhXaJ2oYTdK
 HVxASSx+N+5cmZz5aZ0XtDmolMSSVf4uNb8BawFAwhNFtJAgzbYUAXYCy6q022sPm1dId2DNm
 DXXEriIqmRZEy/ESdyI9ZUaIy514hVE8y/WwSsPEXXkHA+WOS+wJ8Px/eMZOqKZM9Fx3CFpnZ
 UdMdZnf9KBNYi9EybGgMwKUzh3jucyzvhraM0f9v1Lq31mD9nLtq/lwEIOMv/HZClTN1JG45t
 x+/KeZtfKIpDUhlpDpe8X3OWkQC8UwlYQpwb85QqfDqjHdxqQ1Vh5OMnvf9Q2cK6NAiJye2Y0
 JcZNwG1pTMOYBCYBZJ0Nkjzf8t7pURRYloO5Qf0j0iqAEIXHhS4IYxNLTQmpkveyyo+2qfAm9
 yk8+EEy2JFLT+fqOnxPou1uYFO46zjVPaZWsJvkcl8zHZhf9GdbJYNkSLb1F37EKIElPlTmUj
 RBAADcqLeSZ9hBPzOqXx7ZGgEq/g118/15jT9rfMpn1e1AuUwTz1tDAwIwe4Lqj79LsiymDz/
 eGzm5LI6Xbj3bIfdULCDrAzBlicDE
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33215-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B97284834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series tries to implement AP mode for Realtek RTL8188EU chips.

This is not final. I still have issues connecting to the AP, searching for=
 some
input on what may be the reason or how to further debug issues.

Patch 1 could be picked independently as it shouldn't change anything for =
the
non-AP mode.

=2D--
Changes in v3:
- fix compile errors caused by testing on machine with older kernel
Changes in v2:
- add patch to move dynamic_tx_rpt_timing_counter from ra_info to priv
- convert ra_info to a dynamic array
- update max report mac id after station add/remove

=2D--
Georg M=C3=BCller (4):
  wifi: rtl8xxxu: move dynamic_tx_rpt_timing_counter from ra_info to
    priv
  wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
  wifi: rtl8xxxu: update max report mac id on station add / remove for
    8188e chips
  wifi: rtl8xxxu: Enable AP mode for RTL8188EU

 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 22 +++++-----
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 41 ++++++++++++++++---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++-
 3 files changed, 50 insertions(+), 18 deletions(-)

=2D-=20
2.53.0



Return-Path: <linux-wireless+bounces-37359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bp9lOmZHIGr/zwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 17:25:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F73639263
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 17:25:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IlenalyA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37359-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37359-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3A683302B10
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD73CBE7C;
	Wed,  3 Jun 2026 15:14:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE443AD52B;
	Wed,  3 Jun 2026 15:14:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499687; cv=none; b=cbLF+O3D4RHf1Hb1/CO8HYy96XI8hI5quwVnpfNlkonIn/vBsBZ2yhnJsi3tPW/m2SPvML8cK8VtK6G9WnPG3FrVQ1/7u0YeaxsRhnyYMKXcKVEhkJTfTFxSnFrtcLm49l3V9s+CqMSvGgt6Ki857TMEfMCv/rGzRPRIgtKICEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499687; c=relaxed/simple;
	bh=sfJFFRIt7ZtI5VSlY/vt/ttfsmf0TZHVo6bPhf4KChg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU3La+ykwNB1DOJHqXI2M64gOSeO8yTgL3VlWO3ZjRHbS2XEeOLUxtQYXxg0klwzVrSyJ4XsKkIsK9dOzXo6K/cib16T+jePKGyJzsdWQL3oZ/RVnDG+7oNuAteDVznUSklSwn2KFPFu8/3bddGl/pY5iSTxVa66MdYtp05nEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlenalyA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D741F00898;
	Wed,  3 Jun 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499686;
	bh=q8gVi/KLN4RUu/hl2nIvT0jYawQsD47v53vKakKU8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlenalyAI25X2pwHqJJ8/93TFOIjYZTFa05KP0tQul4B6AoYQ3L4kvq3L+PMWCJK8
	 np0v8vEvaImhcIi/tfzMYPpeQlNAiSPTjUH79S/BY9XNdBParsdx8DvV+a/RtrVovz
	 STm7FiJZCm+lXenwzyUVmPKXRJCzPiWDS3ug/dGt5u5h/NI5ZnjvN+aYOWIg3wgEjQ
	 YGtP0vVDtMsK+aNsxD3d1m8IOv2GA//pgKte7JyuTy4mCo3TnmVP4EZ6rrjCP1W7gL
	 mId5vdfmnudQsqDqSfvvmIUVZjEfhhvaPLvRzFAk01Da9xfwX2mN/CUNSQB9X6b3jR
	 7hEywtPZwtTpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>
Cc: Sasha Levin <sashal@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>,
	Wright Feng <wright.feng@infineon.com>,
	Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Piotr Haber <phaber@broadcom.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	SHA-cyfmac-dev-list@infineon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
Date: Wed,  3 Jun 2026 11:14:10 -0400
Message-ID: <20260603111500.item035@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528055431.4124445-1-rob_garcia@163.com>
References: <20260528055431.4124445-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37359-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,broadcom.com,infineon.com,codeaurora.org,davemloft.net,tuxdriver.com,163.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:duoming@zju.edu.cn,m:sashal@kernel.org,m:johannes.berg@intel.com,m:arend.vanspriel@broadcom.com,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:kvalo@codeaurora.org,m:davem@davemloft.net,m:kuba@kernel.org,m:phaber@broadcom.com,m:linville@tuxdriver.com,m:pieterpg@broadcom.com,m:rob_garcia@163.com,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83F73639263

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha


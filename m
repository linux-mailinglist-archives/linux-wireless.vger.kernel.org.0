Return-Path: <linux-wireless+bounces-10996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D759D948A36
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CA81C226D9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D515165EFD;
	Tue,  6 Aug 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ5NDm+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8AF4FA
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929818; cv=none; b=s6im0UV8baLhJeF7thdOOWat+omT9zZosKcAy2F+UrGGvu0lO885MLhDCSApZ5GIB0VJ/0gQ5ZZDl96RAmfcAxD3OoZGSTbbsvHvj2RbJ+qqL9l7nN0dQiwnRlBqUA+kf4f4JXDD4ioaUK/4uqtcCJbh6E5DeKcsjsv1TPH/j9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929818; c=relaxed/simple;
	bh=yito3hgB7SCHvAuaRIDYkcErz1MAoMbNlfM/6zmCbQg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jtbBAQ/wE51HawuSYvoI7dsfEWCbjkShXQ+vZd1NogebEZG0YTmYlSKf0ex6OlgnzMeCEK2jabBRJYaaXkXduFuanLuWHyWqsLwHLvJLEVtsIUBGZrXfy1Q9osXqRoOb5OoPB3Ju1bsDfbP0lV+bUYcY53cuAZg7TREbG20m8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ5NDm+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EEEC32786;
	Tue,  6 Aug 2024 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722929818;
	bh=yito3hgB7SCHvAuaRIDYkcErz1MAoMbNlfM/6zmCbQg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GQ5NDm+nmcVLNH0FqnzsA9AYPV2aMMfzvK3L2BVRvnTKvOb1ISDR1SDKRcFDW12Fv
	 +XsvcDfLHfTY4VpvsokuPdKsGEksmsWPx3I+STzh7UQpFf8vUYA5xmuFtn8Cfvivdu
	 IqYQ+GDRY/idmmhoUNn7S3J79VjjGpFkKSz7jydXD2a0mtxZMph7XVdCNwAFhgpeKF
	 UCcK3/MVd2um1bhIpQud45zQNPR14jNwnQGBaQf2ngqYa3OHUk/CRloTaCEO76gmoz
	 8t9SpWdUiUUij6a/Dh7H+xksPru6pxDLkntruQOuV1pQ5PC2YNCxOo0cdjl5h5LE0v
	 NoXnaQqPVr1eQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: ath12k: add configure country code for
 WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230914090746.23560-2-quic_wgong@quicinc.com>
References: <20230914090746.23560-2-quic_wgong@quicinc.com>
To: Wen Gong <quic_wgong@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172292981507.3540390.14117547883755048860.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:36:56 +0000 (UTC)

Wen Gong <quic_wgong@quicinc.com> wrote:

> Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware which
> is used for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Dropping this now, please rebase if still needed.

4 patches set to Changes Requested.

13384892 [v2,1/4] wifi: ath12k: add configure country code for WCN7850
13384893 [v2,2/4] wifi: ath12k: add 11d scan offload support
13384894 [v2,3/4] wifi: ath12k: avoid firmware crash when reg set for WCN7850
13384895 [v2,4/4] wifi: ath12k: store and send country code to firmware after recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230914090746.23560-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



Return-Path: <linux-wireless+bounces-16703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B037E9FA8F5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61FE7A10E8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E112D51C;
	Mon, 23 Dec 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="p9Gr6pLh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F46FB0;
	Mon, 23 Dec 2024 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917531; cv=none; b=RRvdtWx4sjY31YzUz56JL8TwoA+XxAHwp709Tc4odSpHuS8STM1KBlm59nmgVulr+pXMemahGV/RJONJ5ELNH4NhJhz8Rnqrn/YRStL8SS29VN6QRlqwwuYHJE3wS5QTBqxU9EJB2laPkZh3GezBiCTc8Ou1Y2dogwpDOb2raUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917531; c=relaxed/simple;
	bh=DYo/ezdEvdogKUje77ZyDN7nIqDujzCPRUB1D0t3wdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obDF/kTYETo9Ipop3hC8Vl7txBXa8cRoVA16iglud3iTSN5P3L2tniWNR+ZdcEXOhlHW5hJ2ZqEKV0ZS76uEyVYN9R9X1q1MBgEY9XQ+NSuYlakcTXi/z/G4+LwzcNQWO70OqLz0vqIWjowXXk2nzXCvkMI7k5yxLe/XOvVHw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=p9Gr6pLh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+63eZCR5P/7LT2uMTiqXdlHyWMutjsqM2OC9ssVPkPY=; b=p9Gr6pLhfVm0vlvK
	lyG+QAL52rdYm3eLtpK9Su03QU7d5+vP/jE/yw8mWt8IKE2REpti02Nfl2glsN0vd95Otp4YS21gA
	Napw4x+sFXSQ75PZP1Zao/7o/70i1Uv5qLDgh7V/ct/Tgai5QxyKU8AtHwMwyLclUsDzeEVJ3vQyS
	zT59E8c0rJhBiZOfkeDpOG40r68dnT+iRH/0fy/weh/W6VLnkvpbNEufiVbpsjg1LoMYMhTZxwsLT
	LkRjZKPeW8yQH/QmrqQiZiGkoK3T4u3/X8FMHhfs9GUf2s481tbzU4RVKUM8I0hPWJlwE0Nzt5zzi
	WXqUEruy5F57Or1stw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIh-006oGv-2S;
	Mon, 23 Dec 2024 01:32:03 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/6] iwlwifi: Cleaning up deadcode
Date: Mon, 23 Dec 2024 01:31:56 +0000
Message-ID: <20241223013202.340180-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This is a collection of removal of functions
that have been used for more than a few years.

  There are also a handful of string and one structure
removal that are just left overs from a recent commit.

They're all entire function/structure/string removal.

Build tested only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (6):
  iwlwifi: Remove unused iwl_rx_ant_restriction
  iwlwifi: Remove unused iwl_mvm_rx_missed_vap_notif
  iwlwifi: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
  iwlwifi: Remove unused iwl_mvm_ftm_add_pasn_sta
  iwlwifi: Remove unused iwl_bz_name
  iwlwifi: Remove old device data

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   1 -
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   8 --
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   1 -
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |  11 --
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |   1 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 -
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 101 ------------------
 .../intel/iwlwifi/mvm/ftm-responder.c         |  86 ---------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  23 ----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  61 -----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 -
 12 files changed, 313 deletions(-)

-- 
2.47.1



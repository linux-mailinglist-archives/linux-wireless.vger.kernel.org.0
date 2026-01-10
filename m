Return-Path: <linux-wireless+bounces-30626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C16DDD0D2CE
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 08:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7791230245C2
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997111D618A;
	Sat, 10 Jan 2026 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lcsipWok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02F2AEE1;
	Sat, 10 Jan 2026 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768031278; cv=none; b=raUqCM0xsproSL4CBq4WP48V8Ny/QpgJmfJEe81WoXi1FGnyzHrP1elNge9Wi2p8Ah1z+0dCQHnLtnkz0pxwZ05Ai/CUfIqnWHIlDRDAbMtSiYbxiTQlIKhp3ASliWfM6AMDmREVkdZGnwmbXkYOqgAE4vnrqNMdCkayvdNrh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768031278; c=relaxed/simple;
	bh=bhruphp32DOf5WTKGToDZdAU6jgHn65slWwOea11e5Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kqdiXruuGwBby6va9qnQ/+KwAcXOZPIIEy/a5JKZW2ORsQM4RVESLR9fJsLIFF+S6vmots37hgXooT4qFnHc4n/yau1L/eDK4ImVwUfijvx+tz0OmW9YUTlsfNTXBGtRXg+lTBfqzBv9bVuCgghX0Amjc1UoEAsXDTo9CSteRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lcsipWok; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768031267; bh=bhruphp32DOf5WTKGToDZdAU6jgHn65slWwOea11e5Q=;
	h=From:To:Cc:Subject:Date;
	b=lcsipWoktXPDGlskvTYY1J6ay4NwH8vumrEMdRxotLCB/f7NL89mtpAzoeKa9Zs8M
	 UOq05i++ymZQU9hv9KhqJJAGqdgaO/HxVysfoD+/h7WLgKDUg8gZXNLd6zzI4rYf9n
	 lpuEAHw21UfVYXrolY6fJc6L5URGTvyf3IgNcIFM=
Received: from cjz-VMware-Virtual-Platform.localdomain ([110.176.75.164])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id BEC3448E; Sat, 10 Jan 2026 15:47:44 +0800
X-QQ-mid: xmsmtpt1768031264t4jipfc3w
Message-ID: <tencent_1726B023EBD3D2ED3BBDF506F6E01D282907@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7ire6JwyzampLJIwLkr/US1JlfDCARz7qprklDQ2LoyWWm5aZb5
	 pruW+ymMxsnHBW4yBoEQtjGv3u4S1p6A22/GdyGKPzF73CXiDPrewO7/AZXql5J+Ypk5zdWzQH2z
	 cwjS7FQhvFnq6E4ddxGOwrUC6MOExoDnDFeHNSlgg1ANiV8LWJSiba7R9wHUYxJsKIBKtRjDW38+
	 XSpRKHdaxG4bAOetthIz4AEtLBc+XdYUP0vEMO5PfSMZaHPcjaXo4Q5cTLgqSIWIOXTsBHhpUSEF
	 +vvlTAohKy9RI+C//WBbK8lxDSF90NSXwKuuQL3spNg1Uj50C+XeP+e4vnl7+MK0crFJVo4Nr0+u
	 EfYtHMtkUP46j3AT1106tONxXJlZ6q8JM6/+qspXYdeHJsvjtyIS72h5i8nQ1DqQTRkSBTh49eNF
	 PfnJbrqEY8Ld0H0py0gvGsZwBgVAQXIHXgeWnstwuANNidMcUWq/1E0cHtJUY3/duhguqghzBA3V
	 0Hi3kmchl+rkZWjs9xve7PCzPVEz1TMFdbFZUaICqk8ACMammM9pmTOihkjUI5/mcpR/KBExRUW/
	 Ypsb4PbnrJQ0hOvDyTIdYEpsVneg5SwuEC94N09CDMLJX1wxE+oD0LGuJgUNtVM9fHYen5dpQypv
	 gknadr2VxZHGYCnygdNJREK/iBiMRXvZWJmhmvxJhPYvx8UZOQrj3ZI5nZsoCDD2RBUxqbPCmfwR
	 eA8WK5oWoYQK6Pr2W4LRf45CP17BXtKZKiybHiTBPw1WX1mFrHKSRbXswBcHz1PdjpG9RcfQ5gTi
	 DErOO55jEA1gWoS3cEdd1aHsT9eHWGYl0w5G3phvoIgGK/DiqyDLNmtsl+mWy3kB0CiUgFyQgl7F
	 btj+6E6XOcWZyeCFSZoY4UEFCMJRm7FgaL04EeikqDTtaas8cfyd1ttxjxX1iEYDYt08UkgZVHml
	 eJcZII3ZJOB/1LaoGP2ytkBzrStfAXIp+5nAJKIFsjWecnFW6FKw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: cjz <guagua210311@qq.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	changjunzheng <guagua210311@qq.com>
Subject: [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and replace global io error var
Date: Sat, 10 Jan 2026 15:47:39 +0800
X-OQ-MSGID: <20260110074742.4731-1-guagua210311@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series optimizes the IO error counting logic of the rtl8723bs wireless
driver by removing redundant atomic_t operations (unnecessary for non-concurrent scenarios) and replacing the global continual_io_error variable with local error counting. The series is split into logical patches (per Greg KH's review comment)
to ensure each patch fulfills a single, clear purpose, which greatly improves
reviewability and future maintainability.

Patch Breakdown:
1. 0001: Add independent rtw_check_continual_io_error function (single responsibility, includes old function cleanup)
2. 0002: Use local error_count in sd_read32/sd_write32 (eliminate global dependency, remove atomic ops)
3. 0003: Remove redundant global continual_io_error variable (clean up struct)

Changelog from v3 to v4:
- Split the monolithic v3 patch into logical, single-purpose patches
- Fixed all coding style errors (trailing spaces, missing assignment spaces, indentation, blank line alignment)
- Added detailed, purpose-driven commit messages for each patch
- Added version changelog as required by kernel documentation
- Added this cover letter to explain the entire patch series
- Optimized the new check function to remove redundant ternary expression (more concise kernel style)

Thank you for your time and review!

Signed-off-by: changjunzheng <guagua210311@qq.com>
---



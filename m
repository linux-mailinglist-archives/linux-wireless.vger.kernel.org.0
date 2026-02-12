Return-Path: <linux-wireless+bounces-31763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DwvNH6qjWkK5wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 11:25:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85D12C74D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9DFC303C2BF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A529BD87;
	Thu, 12 Feb 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TP3HfEze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B01C4A24;
	Thu, 12 Feb 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891897; cv=none; b=LclHtdnwd3/QR8+XVu2OcyM5mgv40hm+ry7721HbN5WpyKDSaag+qw85e77AjKjJYh4/4LcS1tISooA0rYxjjVW8yMqk43dkI5vTf1kn1d7m9MnLOhOGdlqGFPpAHflNlf8b6ijc4O59Q6V0Qji9WGf0+k9P+LnxhVoxDHna3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891897; c=relaxed/simple;
	bh=Q1mgWVleEE0wyf7KXIaG1atYZg87rJLD9jD9rv73Zxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ8zUZMTIKmWuLJ5+Dchm8Hovt0cLTbnmpkH5PPDkAU7Mm3A8hkRBOQ0JYPMlnhKn/YwFLlnFA6ABX1ZlvuUhuB+DBLhmR9UJ8E4+sIZuIOFeNCcbROoCL3dL9qsa0UY7DrVXQYuDplw6NS5SQ93sYWuY0Cc7fONT+gG8KHD3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TP3HfEze; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770891895; x=1802427895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1mgWVleEE0wyf7KXIaG1atYZg87rJLD9jD9rv73Zxc=;
  b=TP3HfEzepY88WwL4j6dxlKJfs6JgebjmQDdrfR7K08BOQkUQr9x53P59
   dxk0PZbKyk6iS6KkxJ90mJmoVXkVQWEqzAQuTRpY/AhN/hYeDE+wXSQiM
   cfa/3TpHbxshA1mxfEAsaDYCebFqC89XKcUYXdpyEibxUdOV40gMmlDnv
   EN5W05vVPEnz2a3qQlf4R2zfsgE1jW0LzRismPs/V9FQAhR0Y4NIvWW5u
   qwqlS9YbIlNgmTLEiBMp2SUf2DS/5KTIGd20jJgALbjegufHUkd6TZgdK
   2TNiyqVkzkyqpEli7eT386ficB+U3Bgv+YaJQOBiohwYIf1dWGP3VNC6D
   A==;
X-CSE-ConnectionGUID: bWryUqVuTAWcoXyHUxcrHg==
X-CSE-MsgGUID: yDdx/szhQs+h32pDEtaXlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75684952"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="75684952"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:24:54 -0800
X-CSE-ConnectionGUID: w92L+W/iTzySPvh6OtFRUw==
X-CSE-MsgGUID: f9HdQho0SvCpTUUQIBLK6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="212664748"
Received: from b580.bj.intel.com ([10.238.152.74])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:24:51 -0800
From: Junjie Cao <junjie.cao@intel.com>
To: miriam.rachel.korenblit@intel.com,
	johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	richardcochran@gmail.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yedidya.ben.shimol@intel.com,
	avraham.stern@intel.com,
	daniel.gabay@intel.com,
	krishnanand.prabhu@intel.com,
	luciano.coelho@intel.com,
	gregory.greenman@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: ptp: Fix potential race condition in PTP removal
Date: Thu, 12 Feb 2026 18:24:02 +0800
Message-ID: <20260212102402.1283533-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <DM3PPF63A6024A9E1EF4081E342AF4BED81A365A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31763-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C85D12C74D
X-Rspamd-Action: no action

Hi Miri,

You're right -- cancel_delayed_work_sync() handles re-arming by design,
and the work is scheduled with a 1-hour delay (IWL_PTP_WRAP_TIME =
3600 * HZ), so it cannot realistically fire again during the
microsecond-scale teardown window.

The real issue is simply that the delayed work can execute between
ptp_clock_unregister() and cancel_delayed_work_sync(), observing
partially cleared PTP state.

I'll send a v2 with a corrected commit message, and also split the
patch into two (one per sub-driver) as Simon suggested.

Thanks for the review!

Junjie


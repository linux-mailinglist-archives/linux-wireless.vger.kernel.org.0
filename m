Return-Path: <linux-wireless+bounces-21938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CEA997AC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E5E7A8F7F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643C28D82D;
	Wed, 23 Apr 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H3D2KdsW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5228CF6D;
	Wed, 23 Apr 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432249; cv=none; b=QPPzrafjCfOCEAm4tdLta/UDSQokXkwO/wsfvNrjfqw4Oyuy3EO66wdtfDI2cHfj+ws5Ma8DNXckSkryfYYzIXot2rQry4AI4A1JL8bYNFMuGg45S2iT4kfqhK5MpEHZ6c+HeTjZdv+fc+NjhWK5+xgXg0brxUnwfX/ik/5vzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432249; c=relaxed/simple;
	bh=cWViDUuxcwp4/QVdZ3TBEnvofiMGdKFWJSsT4185cWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BARUX7S+r23m3xmP1OsUOqXEcrQtXwm5UKcpNuoBRZfNvZc7WKrV0U7eS21m3atElr8zjhTJt+ZyOFtJd2fFUI+HWMFjTGkJ0LF7jKq6KcPbM6N9GQfji40a5lIkiSsch8Hxq3ytXiqrBz6nLIodozBi/Hthn9y0aEZfSaVCZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H3D2KdsW; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745432248; x=1776968248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqfu2rj6ntU/1h7MczMuErOve4BDb+YoGDcVuGCnHY4=;
  b=H3D2KdsWAzESkCW3Omfcr3LkCjN1qH/Xn7KeTPmf0T28exm7Xiec09lm
   NGLXxLUXsIupKRIr7brrym7ClWIlG0tDc1PhUTsQqizROuurxJeHffUVR
   IOkHY+6QB3Nc0nt3ZnRRiJIafQDoJCa8R1q1nGoTlIiVxM1DlzKTaoiUv
   k=;
X-IronPort-AV: E=Sophos;i="6.15,233,1739836800"; 
   d="scan'208";a="190040270"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:17:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2327]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.240:2525] with esmtp (Farcaster)
 id 44cf353b-ca45-47b7-b2b2-94e0c0015865; Wed, 23 Apr 2025 18:17:26 +0000 (UTC)
X-Farcaster-Flow-ID: 44cf353b-ca45-47b7-b2b2-94e0c0015865
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 18:17:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 18:17:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <i.abramov@mt-integration.ru>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cfg80211: Restore initial state on failed device_rename() in cfg80211_switch_netns()
Date: Wed, 23 Apr 2025 11:16:40 -0700
Message-ID: <20250423181714.24628-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <4a91f731c49d3449632f19dcf4a1a8f5a9eb847b.camel@sipsolutions.net>
References: <4a91f731c49d3449632f19dcf4a1a8f5a9eb847b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 23 Apr 2025 17:44:45 +0200
> On Mon, 2025-04-07 at 15:53 +0300, Ivan Abramov wrote:
> > Currently, the return value of device_rename() is not acted upon.
> > 
> > To avoid an inconsistent state in case of failure, roll back the changes
> > made before the device_rename() call.
> 
> This kind of seems complicated for something that ought to not happen
> ...
> 
> And also (+netdev), what do we do in case this is called from
> cfg80211_pernet_exit() - leak the whole network namespace because we
> couldn't allocate memory for the name? That seems counterproductive.

default_device_exit_net() does BUG() in such a case, it doens't
assume -ENOMEM as we are freeing memory in the netns dismantle.


static void __net_exit default_device_exit_net(struct net *net)
{
...
	for_each_netdev_safe(net, dev, aux) {
...
		err = dev_change_net_namespace(dev, &init_net, fb_name);
		if (err) {
			pr_emerg("%s: failed to move %s to init_net: %d\n",
				 __func__, dev->name, err);
			BUG();
		}
	}
}


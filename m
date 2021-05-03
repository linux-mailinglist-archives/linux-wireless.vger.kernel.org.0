Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C81371908
	for <lists+linux-wireless@lfdr.de>; Mon,  3 May 2021 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhECQSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 May 2021 12:18:07 -0400
Received: from mx3.wp.pl ([212.77.101.10]:4270 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhECQSH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 May 2021 12:18:07 -0400
Received: (wp-smtpd smtp.wp.pl 18097 invoked from network); 3 May 2021 18:10:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1620058232; bh=8XGMuOBeACwEZMaYGesUMGBNwiLNiNz4H3wfdfgzzwU=;
          h=From:To:Cc:Subject;
          b=Qa3B+RxHIksrBt+KGFLhksmE7j49UlPumqfx+pf1iAdp0wLw9BF/5d57pSNQE5aFj
           jxZkA1l/onJo3jZMXu17+xxR6jTb6B5Wcxskf01a3biykzWQPfmzuKIr5WK4K3psFl
           aZMOiiTFoukLWJb0+MnCFqYmZ4WbPdyR1rr16PZQ=
Received: from unknown (HELO kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com) (kubakici@wp.pl@[163.114.132.4])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <sdlyyxy@bupt.edu.cn>; 3 May 2021 18:10:32 +0200
Date:   Mon, 3 May 2021 09:10:25 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Yan Xinyu <sdlyyxy@bupt.edu.cn>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, matthias.bgg@gmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt7601u: Add support for Baidu Nuomi dongle
Message-ID: <20210503091025.64797075@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210503084735.78974-1-sdlyyxy@bupt.edu.cn>
References: <20210503084735.78974-1-sdlyyxy@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 16ae4f722a5b67e65c97582037b71b81
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [oQLj]                               
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon,  3 May 2021 16:47:35 +0800 Yan Xinyu wrote:
> Add VID/PID for Baidu Nuomi USB WiFi dongle
> 
> Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>

Acked-by: Jakub Kicinski <kuba@kernel.org>

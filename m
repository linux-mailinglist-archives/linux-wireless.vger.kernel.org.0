Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46002226F4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGPP10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 11:27:26 -0400
Received: from mx3.wp.pl ([212.77.101.9]:54064 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgGPP1Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 11:27:25 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 11:27:24 EDT
Received: (wp-smtpd smtp.wp.pl 19161 invoked from network); 16 Jul 2020 17:20:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1594912843; bh=9fW0B4oNSv7yIfxXl+ZhVAEj7F5U6ofqhppdKS8yicI=;
          h=From:To:Cc:Subject;
          b=NXoL1QNeh7f5kKHa8b64OONYUMK8ef8n4vBRndg256WRGXWlJ4nzqK/NSauttb518
           6FiteDjqG4DvNrD+hn5KEZ5row1gIRJaAS8VFI6skKTqMPxyMDwtLfF+oLzIovNTrn
           bJQLNHSEDuhUc0/O0Dl1JsQaWZfuDpLTdd+Cl9t4=
Received: from unknown (HELO kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com) (kubakici@wp.pl@[163.114.132.6])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <miaoqinglang@huawei.com>; 16 Jul 2020 17:20:43 +0200
Date:   Thu, 16 Jul 2020 08:20:36 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200716082036.76f47d2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200716085749.11105-1-miaoqinglang@huawei.com>
References: <20200716085749.11105-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: b8cff0b399aaf7118fc46ef4354c9176
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [UbKj]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 16 Jul 2020 16:57:49 +0800 Qinglang Miao wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Acked-by: Jakub Kicinski <kubakici@wp.pl>

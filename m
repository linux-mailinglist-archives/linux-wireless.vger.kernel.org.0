Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAB168F16
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgBVNY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:24:27 -0500
Received: from mx4.wp.pl ([212.77.101.12]:60708 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgBVNY0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:24:26 -0500
Received: (wp-smtpd smtp.wp.pl 21603 invoked from network); 22 Feb 2020 14:24:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1582377863; bh=+0qmHbLF659xUQZKZaxkZgmGvrnpcpA05FS/lBxb+48=;
          h=From:To:Cc:Subject;
          b=CJDuyE1j0GV/BamrEsZVY0c3TN/RmvangEMIQAhzC9HyzCd+N2sJ9fFHrIHsQRAN1
           01ikLcOhMxulpOm+WqKHiI4K1uRWR43Zp6WhCyEjWg2uMnwUHbt7CcUVX40qW6/sgj
           RMxD1s4WNqvL+dmzMILgOeNf1PXZctxw6LJebqcM=
Received: from host-178.215.207.168-internet.zabrze.debacom.pl (HELO localhost) (stf_xl@wp.pl@[178.215.207.168])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <vulab@iscas.ac.cn>; 22 Feb 2020 14:24:23 +0100
Date:   Sat, 22 Feb 2020 14:24:23 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     kvalo@codeaurora.org, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: Remove unneeded variable ret
Message-ID: <20200222132423.GB231359@wp.pl>
References: <20200221104303.3901-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104303.3901-1-vulab@iscas.ac.cn>
X-WP-MailID: ae4c926b1953536d80ef945438b5bf3c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EfOk]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 21, 2020 at 06:43:03PM +0800, Xu Wang wrote:
> Remove unneeded variable ret used to store return value.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

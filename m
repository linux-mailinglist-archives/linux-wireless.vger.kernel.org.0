Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2001D5F9F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEPIXP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 04:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgEPIXP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 04:23:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F31A206F4;
        Sat, 16 May 2020 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589617394;
        bh=POWNJDuIU59kAO0d0Yb2/1xXBCdN+4we4QtCfOpiVNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6rw0H5Rl6/qXM1wXakzxQVnqRKraiJZ3M9N0eGH3wynsBL/dLPUDqp1BlvA0cLGT
         axyZ7FH3OajDO4Q85qJmjd6jHGq+V2qfHmNsPCtQgMhmWCRUe3c3OBpC6meyMDNHIm
         abacL+qWJIa1pzSfhXAb7AI7JFJF1EHyOo8Qc1JE=
Received: by pali.im (Postfix)
        id AE6C19FC; Sat, 16 May 2020 10:23:12 +0200 (CEST)
Date:   Sat, 16 May 2020 10:23:12 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Message-ID: <20200516082312.uqxyivkb2v43dqch@pali>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Saturday 16 May 2020 08:17:17 Ganapathi Bhat wrote:
> Hi Pali,
> 
> Thanks for this notice. We will try to push the new firmware and also, fix the naming problem.
> 
> Regards,
> Ganapathi

Thank you! Please consider extending kernel driver to load firmware
from filename sdsd8997_combo_v4.bin which is already stored in
linux-firmware repository. Also this is name which is used by marvell
(out-of-tree) kernel driver mlan.ko/sd8997.ko.

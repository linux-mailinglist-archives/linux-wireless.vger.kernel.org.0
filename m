Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66744404
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfFMQe0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:34:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbfFMHwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 03:52:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6331060867; Thu, 13 Jun 2019 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560412352;
        bh=NbvNnEf/EbWWQOzS8Gf0vDTHl4VPoDEjxDUufoehVCg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kDRSZKXpr7ZUSDbY07ysmcNMjuu8AuaHYr5xjjEAU4QM+98iXKz5D1MVH+2JM+Nhw
         0okX8C9Gsi3lDA86FBMqwci4HqUj2V0Z0cWr9eRE6Twv9oYdy1wuj6tzW47164zZJQ
         ckzNVDy/40uqxlG8ceTeoCo50LI4t1n1HJP0nNpg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B2E7602F4;
        Thu, 13 Jun 2019 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560412351;
        bh=NbvNnEf/EbWWQOzS8Gf0vDTHl4VPoDEjxDUufoehVCg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WhenjCpB7p84TaLHqHhvekQmUBAOR+kPZ3nFZvrOer7C09umwSirwxjKT0yNmTMUS
         na+NKBfqx+U+ucjTOhvaxBtfQQUlqyHPM5tIkwbJHuLPwsFBFXXGkfAWN/63e2/HH5
         xPmOB7hTb4SrvJgNwjLAMwE2y/5H+6/LkzMqW0hg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B2E7602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [EXT] Re: mwifiex: update set_mac_address logic
References: <CY4PR18MB123726E26A33B0E4F48E785FA0580@CY4PR18MB1237.namprd18.prod.outlook.com>
        <87pnqbxhra.fsf@purkki.adurom.net>
        <MN2PR18MB26370061E95E43F826F4E53FA0EF0@MN2PR18MB2637.namprd18.prod.outlook.com>
Date:   Thu, 13 Jun 2019 10:52:27 +0300
In-Reply-To: <MN2PR18MB26370061E95E43F826F4E53FA0EF0@MN2PR18MB2637.namprd18.prod.outlook.com>
        (Ganapathi Bhat's message of "Thu, 13 Jun 2019 06:55:23 +0000")
Message-ID: <87o931diro.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> writes:

> I did resend the patch with 'git send-email':
> https://patchwork.kernel.org/patch/10990209/

Thanks, I see it now.

-- 
Kalle Valo

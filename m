Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2F47DF03
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 07:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346603AbhLWGTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 01:19:37 -0500
Received: from verein.lst.de ([213.95.11.211]:52754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234232AbhLWGTg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 01:19:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C78168AFE; Thu, 23 Dec 2021 07:19:33 +0100 (CET)
Date:   Thu, 23 Dec 2021 07:19:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH wireless-drivers-next] bcma: get SoC device struct &
 copy its DMA params to the subdevices
Message-ID: <20211223061933.GA3825@lst.de>
References: <20190121101121.24555-1-zajec5@gmail.com> <2f6de5b7-65ac-ee6a-e0ef-4635f1808379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6de5b7-65ac-ee6a-e0ef-4635f1808379@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please Cc me on the next version. Copying over dma parameters sounds
like the wrong thing to do.

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13812E45B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgABJVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jan 2020 04:21:51 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:52348 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgABJVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jan 2020 04:21:51 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1imwfo-004vDO-9a; Thu, 02 Jan 2020 10:21:44 +0100
Message-ID: <6be80de69f79ae9b93c5595957f863ea759e177b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] iwlwifi: pcie: work around DMA hardware bug
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Justin Capella <justincapella@gmail.com>,
        Luca Coelho <luca@coelho.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Date:   Thu, 02 Jan 2020 10:21:43 +0100
In-Reply-To: <CAMrEMU-qALUNn3njYxomD_2GYUV3MHSTuwjfrC_AFaWybqi3qw@mail.gmail.com> (sfid-20191228_212644_892554_0B0892C8)
References: <20191220115638.1299888-4-luca@coelho.fi>
         <20191223093250.1445654-1-luca@coelho.fi>
         <CAMrEMU-qALUNn3njYxomD_2GYUV3MHSTuwjfrC_AFaWybqi3qw@mail.gmail.com>
         (sfid-20191228_212644_892554_0B0892C8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Justin,

Please trim your quotes and reply appropriately.

On Sat, 2019-12-28 at 12:26 -0800, Justin Capella wrote:
> Would using phys+len & ~dev->dma_mask work in place of the 4g boundary check

No. Look at the value of dma_mask, and the nature of the bug.

johannes


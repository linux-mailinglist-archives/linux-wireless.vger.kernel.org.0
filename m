Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E940283B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbhIGMIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:08:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56098 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343935AbhIGMIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:08:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mNZsq-0007Zf-9p; Tue, 07 Sep 2021 15:07:25 +0300
Message-ID: <ad5ad1ab07e9a2e6ec70e933a313601faa4b7fdd.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 07 Sep 2021 15:07:22 +0300
In-Reply-To: <CAAd53p5udakjRZeFLyrzwtfoq5Vr937CNRghS6_YnCet9yhB1Q@mail.gmail.com>
References: <20210210115637.276676-1-luca@coelho.fi>
         <iwlwifi.20210210135352.889862e6d393.I8b894c1b2b3fe0ad2fb39bf438273ea47eb5afa4@changeid>
         <CAAd53p5udakjRZeFLyrzwtfoq5Vr937CNRghS6_YnCet9yhB1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 05/12] iwlwifi: mvm: store PPAG enabled/disabled flag
 properly
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-09-07 at 19:30 +0800, Kai-Heng Feng wrote:
> Hi Luca,
> 
> On Wed, Feb 10, 2021 at 8:00 PM Luca Coelho <luca@coelho.fi> wrote:
> > 
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > When reading the PPAG table from ACPI, we should store everything in
> > our fwrt structure, so it can be accessed later.  But we had a local
> > ppag_table variable in the function and were erroneously storing the
> > enabled/disabled flag in it instead of storing it in the fwrt.  Fix
> > this by removing the local variable and storing everything directly in
> > fwrt.
> 
> This patch enables PPAG, but it breaks one of HP laptop with Intel 9560.
> 
> dmesg with iwlwifi.debug=0x80 attached in the bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=214343

Thanks for the report.  There seems to be an incompatibility between
the command the driver is sending to the FW and the version the FW
supports.

The commit you mentioned just enables sending this commands, which was
mistakenly not sent before.

Let's continue this discussion in bugzilla.  I'll add more information
there as I figure it out.

--
Cheers,
Luca.


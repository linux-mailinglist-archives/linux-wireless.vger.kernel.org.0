Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399407F0236
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Nov 2023 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjKRTGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Nov 2023 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRTGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Nov 2023 14:06:36 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27744182;
        Sat, 18 Nov 2023 11:06:30 -0800 (PST)
Received: from [192.168.1.103] (31.173.87.19) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 18 Nov
 2023 22:06:15 +0300
Subject: Re: [PATCH 00/34] biops: add atomig find_bit() operations
To:     Bart Van Assche <bvanassche@acm.org>,
        Yury Norov <yury.norov@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Disseldorp <ddiss@suse.de>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jiri Pirko <jiri@resnulli.us>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <alsa-devel@alsa-project.org>, <ath10k@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-media@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-net-drivers@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <netdev@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>
CC:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <792fc3d8-6834-48f8-9737-f1531459d245@acm.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cb01a8af-d62b-27b4-f6fc-d1f3fbf676ee@omp.ru>
Date:   Sat, 18 Nov 2023 22:06:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <792fc3d8-6834-48f8-9737-f1531459d245@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.19]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/18/2023 18:50:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181454 [Nov 18 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.19 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.19 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.19
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/18/2023 18:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/18/2023 3:15:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/23 7:18 PM, Bart Van Assche wrote:
[...]
>> Add helpers around test_and_{set,clear}_bit() that allow to search for
>> clear or set bits and flip them atomically.
> 
> There is a typo in the subject: shouldn't "atomig" be changed
> into "atomic"?

   And "biops" to "bitops"? :-)

> Thanks,
> 
> Bart.

MBR, Sergey

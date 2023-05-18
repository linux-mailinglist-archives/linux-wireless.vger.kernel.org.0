Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBA7085A7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjERQJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERQJb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 12:09:31 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 09:09:29 PDT
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E9FE
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 09:09:29 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=u4Sb+J9xIbgmeHnyvDBIZWrso5nllgTKj16b5k8vWFbHQWu7GhFNcBGx+IAlS4Bk65mVgrsH0l4YLHqapNELnZ3I3dKAuQYmP88mmZkD6dRnU7WaQrOYaU/vBax1WhJ2whSkeSF4iw/K9CSMI1b+RhwLpIvzKo4NSBgqebnVupyZOwRSdhlah7ss0+QMPmeGcsNvWyYGJV9/Crq1EbAotjHa+LqCx/tCI1v6BKnpSdxSKDJFA0xaEUnHGPM4oGsLPHnWmqC+RBzJ8aXBWkJLuPoaIH3nDNDoeze0LpsenC9jWuR0OEQ7/eXv9JQbjB636Tu/YrrPgdc2w+nndOudJg==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
Received: (qmail 1600715 invoked by uid 108); 18 May 2023 16:02:47 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 18 May 2023 16:02:47 +0000
Received: from dummy.faircode.eu ([98.124.53.137])
        by titan.fastwww.net with ESMTPSA
        id 5bbKASdMZmTHbBgApSktOw
        (envelope-from <bjlockie@lockie.ca>); Thu, 18 May 2023 16:02:46 +0000
Date:   Thu, 18 May 2023 12:02:45 -0400 (EDT)
From:   James <bjlockie@lockie.ca>
To:     Fabrizio del Tin <devotedmystic@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
In-Reply-To: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
Subject: Re: Realtek RTL8832CU compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ask here: https://github.com/morrownr/USB-WiFi

May 18, 2023 11:05:50 Fabrizio del Tin <devotedmystic@gmail.com>:

> Hello,
> I got a recent RTL8832CU
> (https://es.aliexpress.com/item/1005005544770386.html?spm=a2g0o.productlist.main.1.78ff96c6qceFKn&algo_pvid=9ee2eb8d-9883-4709-90f5-0dc6d98c40da&algo_exp_id=9ee2eb8d-9883-4709-90f5-0dc6d98c40da-0&pdp_npi=3%40dis%21EUR%2161.26%2130.62%21%21%21%21%21%402145277316844042289821012d07b5%2112000033481930568%21sea%21IT%211918944861&curPageLogUid=OMcZ7AW58cDB).
> It's a very affordable tri band usb wifi 6 card, which is sold as AXE3000.
> 
> I tested it on Arch Linux, kernel 6.3.2, to no avail.
> 
> Once inserted, it gives:
> 0bda:1a2b Realtek Semiconductor Corp. RTL8188GU 802.11n WLAN Adapter
> (Driver CDROM Mode)
> 
> After an eject cdrom, it gives:
> 0bda:c832 Realtek Semiconductor Corp. 802.11ax WLAN Adapter
> 
> I wonder if there will be any plan to make a Linux driver for it. The
> only tri band in kernel solution seems to be the Netgear A8000, which
> is widely available, but very expensive. The ALFA AWUS036AXML cannot
> be found in my country. And there is no other option.
> 
> Thank you,
> Fabrizio Lanza

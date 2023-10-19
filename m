Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F97CFF44
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJSQSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSQSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 12:18:05 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 09:18:03 PDT
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C89B
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 09:18:02 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=nqbiGw1wH7sr7vdBhzRT2zvAbz2QlluWNxAH1T7v7xjIxym+8nHLBT7yP7ZHIptD24NhUiCVa+8hTq+NvJGo03p8P0BRUh/fkLF5vJDVem2pt2aUq9HGCQCP7Kqg6r00Y3t9eIWrylRD+znDXJw/NllsahuAKueSUlhHIUYx1HvL5Elk75H0UccS0Hot6S40vJ4RRDcG+O8nOn50+npPVpKS33EO/w0D149us3OXiPnbnTXitLMNXox/+pWCfFwRTpdiqEljhOY6SDGrsKERaXY47M25430CJMAoAbYEz3jyk7I/k/qsesrNh/fi9nIh65TLo8HQPSGLgp1sfQ08UA==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
Received: (qmail 3847486 invoked by uid 108); 19 Oct 2023 16:11:21 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 19 Oct 2023 16:11:21 +0000
Received: from dummy.faircode.eu ([153.92.40.73])
        by titan.fastwww.net with ESMTPSA
        id z1WqAylVMWU6tToApSktOw
        (envelope-from <bjlockie@lockie.ca>); Thu, 19 Oct 2023 16:11:21 +0000
Date:   Thu, 19 Oct 2023 12:11:16 -0400 (EDT)
From:   James <bjlockie@lockie.ca>
To:     Jon Doe <tuksgig@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <ce544a72-2af6-4448-8817-1d4cb54f456a@lockie.ca>
In-Reply-To: <CAMes48--xvNjYZdO1DKjfkXRv7AJcqJaWYzJ9fYSPPxQ_M7muw@mail.gmail.com>
References: <CAMes48--xvNjYZdO1DKjfkXRv7AJcqJaWYzJ9fYSPPxQ_M7muw@mail.gmail.com>
Subject: Re: rtw88 usb adapter can't authenticate
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <ce544a72-2af6-4448-8817-1d4cb54f456a@lockie.ca>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Oct 19, 2023 11:00:56 AM Jon Doe <tuksgig@gmail.com>:

> Hi,
>
> I have a Cudy AC1300 model WU1400 USB Wifi adapter that fails to
> authenticate properly. Driver for this device is rtw88_8822bu.
> Reported this previously at
> https://bugzilla.redhat.com/show_bug.cgi?id=2188243 with logs of the
> error messages.
>
> Scanning works but authentication fails after 3 attempts. Any ideas?
Have different SIDs for 2.4ghz and 5ghz.
That causes problems.

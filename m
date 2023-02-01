Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45986867D9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBAOCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 09:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBAOB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 09:01:59 -0500
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 06:01:56 PST
Received: from titan.fastwww.net (titan10.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72C170B
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 06:01:55 -0800 (PST)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=j4uvDZXF6TWIFJNoEUhf8a3ahzhqUeDBjicvF1oeL27jNN3xKUATlsz8EBRw7XrsHs8DNRUVwnqMKEhKrBr2E0P6oTcEX1Ml5C6U2l8adxmj5ps38OaoG9Az9z1YduWz7I72Jvr51BUR3dAeWltd6AWJi6AQSM2zye93Fy+Bi69CWyJFHSwekKB2/ze/oiuwVz1GvUqmy3+GvkQRWBChnZ12rumCp6SW+JJHJnTba5jJ96p69AhBfDbWEzAX4YDArI3ygy984/lwMta/EwsvCnZyssWarLJQIeEi6Fyk6vWiZTRkCGW/Byq7PzVo6GyAIzb+FksTz9gCZKwXJ+hhaQ==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=date:from:to
        :cc:message-id:in-reply-to:references:subject:mime-version
        :content-type:content-transfer-encoding; s=default; bh=E4c6nhz6h
        Y5ux+m97i7oPvqJrIQ=; b=x2Qc8ADfbRdYkx+TmVxwZbZZwLQt/gtUsw9GpuVzl
        2w4us4zJkiLwrI1anXYlE/+/pA4jgmhlX+ZmnZm0pGFCscs1lG+mC5iDvaBbMqYN
        Sbgl+/1LUxighNGuW7GtfGOGipPb4fRLmyZu0pG7OqlGFw+IJKg3MqYbsER4nwOc
        +s3k7sVTgl93aMg56rB3jx7NRMUYcmpJL7TZgyNzKwIX7SS81KIny7EjG/pBZzVA
        Rxi67gGgFFcz23aXaoCwQZjSvoetxuwoZ1ge9MR70J0zKFulHN/zNQpPpSV7c6/O
        FwJJUOm5g4bVf+chVgFYxstD9MYf54L9XYbmRuOmT//kw==
Received: (qmail 12312 invoked by uid 108); 1 Feb 2023 13:55:14 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 1 Feb 2023 13:55:14 +0000
Received: from dummy.faircode.eu ([76.75.122.26])
        by titan.fastwww.net with ESMTPSA
        id UkCgF0Jv2mMWMAAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Wed, 01 Feb 2023 13:55:14 +0000
Date:   Wed, 1 Feb 2023 08:55:11 -0500 (EST)
From:   James <bjlockie@lockie.ca>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        linux-wireless@vger.kernel.org
Message-ID: <956e9d77-79ff-4bf6-af14-d6cf8c181627@lockie.ca>
In-Reply-To: <20230201080058.GH13319@pengutronix.de>
References: <20230131114611.sm6m3fc4g5n7lhqc@fatal.se> <20230201080058.GH13319@pengutronix.de>
Subject: Re: rtw88: rtw8822cu (LM842) stalls completely, needs replugging to
 wake up.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <956e9d77-79ff-4bf6-af14-d6cf8c181627@lockie.ca>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_SOFTFAIL,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's on arm cpus.

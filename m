Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45DF74004A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjF0QEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjF0QEa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 12:04:30 -0400
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439DB2D5E
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 09:04:29 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=EWkRb6ilIElQXJs5gR6UQsSoG/rcPawJVzA+dH7zMvZQtEpAzu/Mif67VjfsUimiAAZpenez4k/mEXZQdcN2L+/8XmE+SEDynyOPKOtyJtRJYQv5RJpYoLynmMOXP3v//2Y63QpoKMiQs69c7OZvCCZFE3oiYDaM1Ocn7dDiFhRxIhJMS0FYC6xKvszSXQ2zB+PpABlb3Hw6WNYAq3Ip1fWpZHv4Hz6Gn9tS3qabsxy9IicQQhZpYYeSrw8fxUmX1FAOBw7QimVF46CrHQiG0f1DtNwpJwj2uE2oIAwwlmVkRIAry3InIi6l2IxSmGQq1ueKLwiW4WiEqcEkKzNgPw==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
Received: (qmail 4090494 invoked by uid 108); 27 Jun 2023 16:04:27 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 27 Jun 2023 16:04:27 +0000
Received: from dummy.faircode.eu ([76.75.107.155])
        by titan.fastwww.net with ESMTPSA
        id BqSPKIsIm2R6aj4ApSktOw
        (envelope-from <bjlockie@lockie.ca>); Tue, 27 Jun 2023 16:04:27 +0000
Date:   Tue, 27 Jun 2023 12:04:26 -0400 (EDT)
From:   James <bjlockie@lockie.ca>
To:     Giulio Paci <giuliopaci@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
In-Reply-To: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
Subject: Re: Realtek 8822ce connection is very unstable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I would try a different distro.

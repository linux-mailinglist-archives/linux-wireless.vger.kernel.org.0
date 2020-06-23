Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC720589C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 19:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFWR2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 13:28:37 -0400
Received: from mon2.sibername.com ([162.144.51.228]:49438 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732961AbgFWR2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 13:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SU7jT4/NnGpltqBIuEtiAKft2rvbESTTBk3Y4BhIHvc=; b=gAeS09tV6TR12bTh8bqzpnpx8/
        RWe8oet7a/JOZ7T6dFBNpM3wW1jQmOtcyLJNuGi9ST6O+BDhIiNQVej5G1kS1rjl4xAGmHgxakej1
        8gkFYASnUeysfiPsIoYd+qmU8340zRjSiv+a243FcjNP4je922cpHUDtXYDdWVzp+CNWLFTedeSO4
        neFbRKtInQUf7F3AZxPmXcWB/uVjsYLndUAIkdZ4MyDAIxLoN6QV4SMrSqf8tRRfOk2iLiNDmy41h
        gbvNXXCamqIgSiLqAWyVhaPjoYMyJEZf6r5tWjyJNZfAXWndXo2NOwDzRIAMzLPzLHq4A1b+PzYmX
        H4V52Org==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:59230 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jnmij-009p3M-3x
        for linux-wireless@vger.kernel.org; Tue, 23 Jun 2020 13:28:30 -0400
Subject: oops
From:   James <bjlockie@lockie.ca>
To:     linux-wireless@vger.kernel.org
References: <1aee86c7-27f2-ee81-9669-8a49aa521dfd@lockie.ca>
Message-ID: <cb1a711c-e584-74e9-0009-dcf019f8a2b3@lockie.ca>
Date:   Tue, 23 Jun 2020 13:28:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1aee86c7-27f2-ee81-9669-8a49aa521dfd@lockie.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: rjl@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: rjl@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-23 1:20 p.m., James wrote:
> help
My apologies, that was meant for majordomo.

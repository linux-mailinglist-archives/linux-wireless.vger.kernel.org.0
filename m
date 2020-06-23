Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9720586C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgFWRUr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 13:20:47 -0400
Received: from mon2.sibername.com ([162.144.51.228]:45883 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732408AbgFWRUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 13:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:To:Sender:Reply-To:Subject:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=; b=YHgYX1JY1yBNKKIob8Q0/bdNS5
        7ivrptitdNbsSVNF/R95arsFthC5j4q9qVweCc+OT1dl/gDShe4SyXDMC3hQStAlxdb+zqEkbAg4s
        0tsL0HaUKEVXA3FNjWNeL4ZpYFciQCvtFzNqaMT2G6XYdT3jgtqe4eo9sih4WR6CiAt20XQBuoM7B
        XPoQCxLsaGpr8ogiBi/ggZZ7KQYYhFYJRnsxfrqTaUpVttYMpMQuw5g0yzshfnHyZ1+Clve1F9YZQ
        oT7hmQnb6XUaSLK4PicXe4AZWb0yzUuWEzbAkOFGGAfHknDWliLRsZMmaUKmIgqMByQE83BhSzPK7
        ITrQrr7A==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:59210 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jnmbE-009mxj-UQ
        for linux-wireless@vger.kernel.org; Tue, 23 Jun 2020 13:20:46 -0400
To:     linux-wireless@vger.kernel.org
From:   James <bjlockie@lockie.ca>
Message-ID: <1aee86c7-27f2-ee81-9669-8a49aa521dfd@lockie.ca>
Date:   Tue, 23 Jun 2020 13:20:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=2.8
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

help

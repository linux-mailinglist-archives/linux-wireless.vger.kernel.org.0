Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FAA1974D2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgC3HD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 03:03:57 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:63258 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728489AbgC3HD5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 03:03:57 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 03:03:56 EDT
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02U6qxqr022694;
        Mon, 30 Mar 2020 00:57:10 -0600
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00183b01.pphosted.com with ESMTP id 3021taudm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 00:57:09 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvHe6PAhrFs7Vii4f4HZz7Wpw1yBFY0GOqbp02VYMJj5ZKjSlEHTzpn5FhgOjJcCn92AGH9qgiuOnp3BmH58lzurTKM4TaFtYx35LI18vdqGzG5TW0iZgpCMxxWhPNQJMbMDlYeobNjMwm7QadYa9lOps4B1nSe12RpSCmxczeNKxrFwoUpyAQuIPoasFUPDu3zhdQv3IVGDaDAo7hU/Z+qjaEUwQndEMHPlRHzg26HB63586wz2HzFmsdvIUfvI1kOi7znBTQ6FRVBG9zqzgIW5dZV5r7fxJKBcm1gFDA9f82FGgh8Vkx78/7udu5NuS0qV/pGsDU4Cyd62/M1I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYNnWfQpHl5IukvVamry4STMcDjRpzrxc0+BhE9BnA=;
 b=GC200iw7N9tWFhKji/mQJFUUU+Who+WpSRE/f7TziQFLLHnrR/wkM33AM1bY/iN0VVI+9WENDBAaHNs4EIAjrxWzYYFgjXIB+pfa8AKlck9wLdXUIchrgQN83qfkKyfxyqV4Jv+mVJtbibHbsrugT5WeaqoGUbvGi0e6MbJmd61o/2Xn7QOwk4Jkm0AuKHvW/anEJGKMtFIaUUrMAyZffURRELMdB164jru8GK+Jovu3Q92n4SOMwuu6m+MIRePyhqUi1C21ciS/33zXCp88owQJseOewQxwm2w77NCFLDk0tbEhQmM2D3v4cpZebyiNCh6kFR5Ekv1bxNJZ+eDvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYNnWfQpHl5IukvVamry4STMcDjRpzrxc0+BhE9BnA=;
 b=GS6S0UR0tbe/COR+M/oERs0JKKCKzW2W4vjcCuZM9wVZU646DUX7gXs9X0g7zlu8AB0Ae7j9KjsetM6r/6zxZmsLcp7/IJ/aN9yMcZuIQaKmyRi9ciaPy8Ke4mfHNSTOLlvKx5MAmYULigxYZnjGCcOCjy+cX+Zxx90yjq8BppU=
Received: from SN2PR05MB2445.namprd05.prod.outlook.com (2603:10b6:804:6::19)
 by SN2PR05MB2704.namprd05.prod.outlook.com (2603:10b6:804:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11; Mon, 30 Mar
 2020 06:57:07 +0000
Received: from SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::a12d:d39f:64d8:ed8e]) by SN2PR05MB2445.namprd05.prod.outlook.com
 ([fe80::a12d:d39f:64d8:ed8e%4]) with mapi id 15.20.2878.013; Mon, 30 Mar 2020
 06:57:07 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3496.namprd05.prod.outlook.com (2603:10b6:910:54::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.12; Mon, 30 Mar
 2020 06:55:46 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::c886:d658:a1c4:1f6a]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::c886:d658:a1c4:1f6a%7]) with mapi id 15.20.2878.012; Mon, 30 Mar 2020
 06:55:45 +0000
Date:   Mon, 30 Mar 2020 09:55:31 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Luca Coelho <luca@coelho.fi>
CC:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 12/12] cfg80211: Do not warn on same channel at the end
 of CSA
Message-ID: <20200330065530.h5i3reym34jnjs5w@bars>
Mail-Followup-To: Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
References: <20200326120042.578777-1-luca@coelho.fi>
 <20200326120042.578777-13-luca@coelho.fi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326120042.578777-13-luca@coelho.fi>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0312.eurprd05.prod.outlook.com
 (2603:10a6:7:93::43) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars (195.182.157.78) by HE1PR05CA0312.eurprd05.prod.outlook.com (2603:10a6:7:93::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Mon, 30 Mar 2020 06:55:44 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c718b7fb-d882-44ef-f62e-08d7d4775f08
X-MS-TrafficTypeDiagnostic: CY4PR05MB3496:|SN2PR05MB2704:
X-Microsoft-Antispam-PRVS: <CY4PR05MB3496202CA7F49AB4627D3527A3CB0@CY4PR05MB3496.namprd05.prod.outlook.com>
X-Moderation-Data: 3/30/2020 6:57:04 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR05MB2445.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39840400004)(66556008)(6916009)(478600001)(16526019)(8936002)(4326008)(186003)(6666004)(52116002)(66946007)(55016002)(86362001)(26005)(66476007)(5660300002)(1076003)(9686003)(33716001)(956004)(6496006)(81156014)(81166006)(9576002)(8676002)(2906002)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72AmPws+1BKLoCAeeQpljRMoG03p1/9GbGxAPfcF0jQ53wTLqbuAfnTqVJHYEIhbu/RlHaZq/zdwzyobGW4FzhMEY4iuxMT1G5rs13QGNpFiuOqlIvwiiQGxhfZ1hFILCfQxLxlOhwA+fumrlyEC2Oeh7GyAA8flTcbGO9tIDSiWV4544ZnTtQ2EKDbh2XPkC+tjp8mM1cF3uoG8rc663wH2+IfwNB550sBaVkXfDCgg8vEgWxmfzZlpGX+MQYhrOd3z3XJ7nUiipuXpKiAXYFBrsE6D+I5hPkrJYgOt7feyeOcy/jvBGolBp1JmMXUNkWB1UqJDK+Uw+GtftwOhLaAuDrQh3dDRhGBOBbx7jOLlP1TjQsMKO3GKxfjaLOlMqMdwVfHclXD9T4SBQBNUo5zUQonewG70L0QgAfjpykFkIxA0mMhkpeXJkE/n7NlJ
X-MS-Exchange-AntiSpam-MessageData: aSNLPgFP86mTzXZplCMzOCDKd4zw5dr4oHSDHZJ21rfUj6K48HbDllg1S/qxGvrl74k3UGlDkv3LDbvBB221ayGU0eyWVyo+M0BF8QvnQPm7UNQO8RGC2HJdjzdFfb/XpVS6lK/cyH6brrvpm8MVWQ==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c718b7fb-d882-44ef-f62e-08d7d4775f08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXqMMf7q/GFKJhAOeJnOzhkx8GCsTBdMUkD1vZROq3zgxTLuWTIRYdgzZwqUaS/3ZeuxJbityweuEsiYZ0jgXXqVpbFw1v+KNs5cErEQ4eceTahB4til1kVa90+M3nT7HNQ+L9M/L7vqNzSWjIcFlcUQ99uLyctHx2eahnuYdXdreY6wLSzvokY+wxssLULf0wGqNGA6WeLtnapb3vB3z6nW3ebn5Kl4Ta9YKsMvoLI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 06:57:07.5645
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2704
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-30_01:2020-03-27,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300065
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> From: Ilan Peer <ilan.peer@intel.com>
> 
> When cfg80211_update_assoc_bss_entry() is called, there is a
> verification that the BSS channel actually changed. As some APs use
> CSA also for bandwidth changes, this would result with a kernel
> warning.
> 
> Fix this by removing the WARN_ON().
> 
> Change-Id: I6710376b1b4257e5f4712fc7ab16e2b638d512aa
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  net/wireless/scan.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index dd41e41f9d26..4000382aef48 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -2019,7 +2019,11 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
>  
>  	spin_lock_bh(&rdev->bss_lock);
>  
> -	if (WARN_ON(cbss->pub.channel == chan))
> +	/*
> +	 * Some APs use CSA also for bandwidth changes, i.e., without actually
> +	 * changing the control channel, so no need to update in such a case.
> +	 */
> +	if (cbss->pub.channel == chan)
>  		goto done;
>  
>  	/* use transmitting bss */

Indeed, that WARN_ON was too harsh here. One more triggering use-case
here was repeater. Thanks for fixing !

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
